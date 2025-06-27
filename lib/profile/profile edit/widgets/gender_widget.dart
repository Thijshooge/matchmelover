import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';

class GenderOption {
  final String name;
  final String emoji;

  GenderOption({required this.name, required this.emoji});
}

class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  String? selectedGender;
  final ProfileService _profileService = ProfileService();
  bool _isLoading = true;

  final List<GenderOption> genderOptions = [
    GenderOption(name: 'Man', emoji: '👨'),
    GenderOption(name: 'Vrouw', emoji: '👩'),
    GenderOption(name: 'Non-binair', emoji: '🧑'),
    GenderOption(name: 'Anders', emoji: '🌈'),
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
      if (mounted) {
        setState(() {
          selectedGender = profile?.gender;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateGender(String gender) async {
    final value = gender.isEmpty ? null : gender;
    setState(() => selectedGender = value);

    print('Gender Widget: Updating to: $value');

    try {
      await _profileService.updateField('gender', value);
      print('Gender Widget: Successfully updated!');
    } catch (e) {
      print('Gender Widget: Error updating: $e');
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
            _showGenderSelection(context);
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
                  'Gender',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                if (selectedGender == null)
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
                        selectedGender!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _updateGender('');
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

  void _showGenderSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return Container(
          height: MediaQuery.of(modalContext).size.height * 0.5,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(modalContext);
                    },
                    child: Text(
                      'Klaar',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Selecteer je gender',
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              const SizedBox(height: 16),
              // Gender lijst
              Expanded(
                child: ListView.builder(
                  itemCount: genderOptions.length,
                  itemBuilder: (context, index) {
                    final gender = genderOptions[index];
                    final isSelected =
                        selectedGender == '${gender.emoji} ${gender.name}';

                    return GestureDetector(
                      onTap: () {
                        if (selectedGender ==
                            '${gender.emoji} ${gender.name}') {
                          // Als het item al geselecteerd is, deselecteer het
                          _updateGender('');
                        } else {
                          // Selecteer het nieuwe item
                          _updateGender('${gender.emoji} ${gender.name}');
                        }
                        // Sluit de modal automatisch
                        Navigator.pop(modalContext);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
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
                              gender.emoji,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                gender.name,
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
                                Icons.radio_button_checked,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              )
                            else
                              Icon(
                                Icons.radio_button_unchecked,
                                color: Colors.grey[400],
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
