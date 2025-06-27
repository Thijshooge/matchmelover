import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';

class Sport {
  final String name;
  final String emoji;

  Sport({required this.name, required this.emoji});
}

class SportWidget extends StatefulWidget {
  const SportWidget({super.key});

  @override
  State<SportWidget> createState() => _SportWidgetState();
}

class _SportWidgetState extends State<SportWidget> {
  List<String> selectedSports = [];
  final ProfileService _profileService = ProfileService();
  bool _isLoading = true;

  final List<Sport> sports = [
    Sport(name: 'Voetbal', emoji: '⚽'),
    Sport(name: 'Tennis', emoji: '🎾'),
    Sport(name: 'Basketbal', emoji: '🏀'),
    Sport(name: 'Volleybal', emoji: '🏐'),
    Sport(name: 'Hardlopen', emoji: '🏃'),
    Sport(name: 'Fitness', emoji: '💪'),
    Sport(name: 'Zwemmen', emoji: '🏊'),
    Sport(name: 'Wielrennen', emoji: '🚴'),
    Sport(name: 'Yoga', emoji: '🧘'),
    Sport(name: 'Dansen', emoji: '💃'),
    Sport(name: 'Boksen', emoji: '🥊'),
    Sport(name: 'Golf', emoji: '⛳'),
    Sport(name: 'Ski\u00EBn', emoji: '⛷️'),
    Sport(name: 'Skateboarden', emoji: '🛹'),
    Sport(name: 'Surfen', emoji: '🏄'),
    Sport(name: 'Klimmen', emoji: '🧗'),
    Sport(name: 'Wandelen', emoji: '🥾'),
    Sport(name: 'Paardrijden', emoji: '🏇'),
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
          selectedSports = profile?.sport?.isNotEmpty == true
              ? profile!.sport!.split(',').map((e) => e.trim()).toList()
              : [];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateSports(List<String> sports) async {
    setState(() => selectedSports = sports);

    try {
      final sportString = sports.join(', ');
      await _profileService.updateField('sport', sportString);
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
        // Sport widget
        GestureDetector(
          onTap: () {
            _showSportSelection(context);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sport',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    if (selectedSports.isEmpty)
                      const Text(
                        'Toevoegen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          _updateSports([]);
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
                if (selectedSports.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedSports.map((sport) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.2),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              sport,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                final updatedSports = List<String>.from(
                                  selectedSports,
                                );
                                updatedSports.remove(sport);
                                _updateSports(updatedSports);
                              },
                              child: Icon(
                                Icons.close,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSportSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(modalContext).size.height * 0.75,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selecteer je sporten',
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
                  const SizedBox(height: 8),
                  Text(
                    'Je kunt meerdere sporten selecteren',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  // Sporten lijst
                  Expanded(
                    child: ListView.builder(
                      itemCount: sports.length,
                      itemBuilder: (context, index) {
                        final sport = sports[index];
                        final sportText = '${sport.emoji} ${sport.name}';
                        final isSelected = selectedSports.contains(sportText);

                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              final updatedSports = List<String>.from(
                                selectedSports,
                              );
                              if (isSelected) {
                                updatedSports.remove(sportText);
                              } else {
                                updatedSports.add(sportText);
                              }
                              _updateSports(updatedSports);
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
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
                                  sport.emoji,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    sport.name,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
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
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
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
      },
    );
  }
}
