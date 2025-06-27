import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';

class ZodiacSign {
  final String name;
  final String symbol;
  final String emoji;

  ZodiacSign({required this.name, required this.symbol, required this.emoji});
}

class ZodiacWidget extends StatefulWidget {
  const ZodiacWidget({super.key});

  @override
  State<ZodiacWidget> createState() => _ZodiacWidgetState();
}

class _ZodiacWidgetState extends State<ZodiacWidget> {
  String? selectedZodiac;
  final ProfileService _profileService = ProfileService();
  bool _isLoading = true;

  final List<ZodiacSign> zodiacSigns = [
    ZodiacSign(name: 'Ram', symbol: 'Aries', emoji: '♈'),
    ZodiacSign(name: 'Stier', symbol: 'Taurus', emoji: '♉'),
    ZodiacSign(name: 'Tweelingen', symbol: 'Gemini', emoji: '♊'),
    ZodiacSign(name: 'Kreeft', symbol: 'Cancer', emoji: '♋'),
    ZodiacSign(name: 'Leeuw', symbol: 'Leo', emoji: '♌'),
    ZodiacSign(name: 'Maagd', symbol: 'Virgo', emoji: '♍'),
    ZodiacSign(name: 'Weegschaal', symbol: 'Libra', emoji: '♎'),
    ZodiacSign(name: 'Schorpioen', symbol: 'Scorpio', emoji: '♏'),
    ZodiacSign(name: 'Boogschutter', symbol: 'Sagittarius', emoji: '♐'),
    ZodiacSign(name: 'Steenbok', symbol: 'Capricorn', emoji: '♑'),
    ZodiacSign(name: 'Waterman', symbol: 'Aquarius', emoji: '♒'),
    ZodiacSign(name: 'Vissen', symbol: 'Pisces', emoji: '♓'),
  ];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final uid = _profileService.currentUserId;
    if (uid == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final profile = await _profileService.getProfile(uid);
      if (profile == null) {
        await _profileService.createProfile(uid);
      }
      if (mounted) {
        setState(() {
          selectedZodiac = profile?.zodiac;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateZodiac(String zodiac) async {
    setState(() => selectedZodiac = zodiac.isEmpty ? null : zodiac);

    try {
      await _profileService.updateField('zodiac', zodiac);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fout bij opslaan: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _profileService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Center(child: CircularProgressIndicator()),
          SizedBox(height: 8),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        GestureDetector(
          onTap: () {
            _showZodiacSelection(context);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white, width: 1),
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sterrenbeeld',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                if (selectedZodiac == null)
                  const Text(
                    'Toevoegen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedZodiac!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _updateZodiac('');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showZodiacSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return Container(
          height: MediaQuery.of(modalContext).size.height * 0.75,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecteer je sterrenbeeld',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              // Sterrenbeelden lijst
              Expanded(
                child: ListView.builder(
                  itemCount: zodiacSigns.length,
                  itemBuilder: (context, index) {
                    final zodiac = zodiacSigns[index];
                    final isSelected =
                        selectedZodiac == '${zodiac.emoji} ${zodiac.name}';

                    return GestureDetector(
                      onTap: () {
                        _updateZodiac('${zodiac.emoji} ${zodiac.name}');
                        Navigator.pop(modalContext);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          border: const Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                          color: isSelected
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.1)
                              : null,
                        ),
                        child: Row(
                          children: [
                            Text(
                              zodiac.emoji,
                              style: TextStyle(
                                fontSize: 24,
                                color: isSelected ? Colors.white : Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                zodiac.name,
                                style: TextStyle(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
