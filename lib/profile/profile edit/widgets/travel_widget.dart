import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';

class Travel {
  final String name;
  final String emoji;

  Travel({required this.name, required this.emoji});
}

class TravelWidget extends StatefulWidget {
  const TravelWidget({super.key});

  @override
  State<TravelWidget> createState() => _TravelWidgetState();
}

class _TravelWidgetState extends State<TravelWidget> {
  List<String> selectedTravels = [];
  final ProfileService _profileService = ProfileService();
  bool _isLoading = true;

  final List<Travel> travels = [
    Travel(name: 'Strandvakanties', emoji: '🏖️'),
    Travel(name: 'Steden trips', emoji: '🏙️'),
    Travel(name: 'Backpacken', emoji: '🎒'),
    Travel(name: 'Luxe reizen', emoji: '✈️'),
    Travel(name: 'Roadtrips', emoji: '🚗'),
    Travel(name: 'Natuurvakanties', emoji: '🏞️'),
    Travel(name: 'Bergwandelingen', emoji: '⛰️'),
    Travel(name: 'Safari', emoji: '🦁'),
    Travel(name: 'Cruises', emoji: '🛳️'),
    Travel(name: 'Cultuur reizen', emoji: '🏛️'),
    Travel(name: 'Avontuurlijk', emoji: '🧗‍♀️'),
    Travel(name: 'Wellness reizen', emoji: '🧘‍♀️'),
    Travel(name: 'Foodie trips', emoji: '🍜'),
    Travel(name: 'Wintersporten', emoji: '⛷️'),
    Travel(name: 'Eilandhoppen', emoji: '🏝️'),
    Travel(name: 'Festivals', emoji: '🎪'),
    Travel(name: 'Solo reizen', emoji: '🚶‍♀️'),
    Travel(name: 'Groepsreizen', emoji: '👥'),
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
          selectedTravels = profile?.travel?.isNotEmpty == true
              ? profile!.travel!.split(',').map((e) => e.trim()).toList()
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

  Future<void> _updateTravels(List<String> travels) async {
    setState(() => selectedTravels = travels);

    try {
      final travelString = travels.join(', ');
      await _profileService.updateField('travel', travelString);
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
        // Travel widget
        GestureDetector(
          onTap: () {
            _showTravelSelection(context);
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
                    const Text(
                      'Reizen',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    if (selectedTravels.isEmpty)
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
                          _updateTravels([]);
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
                if (selectedTravels.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedTravels.map((travel) {
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
                              travel,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                final updatedTravels = List<String>.from(
                                  selectedTravels,
                                );
                                updatedTravels.remove(travel);
                                _updateTravels(updatedTravels);
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

  void _showTravelSelection(BuildContext context) {
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
                        'Selecteer je reisvoorkeuren',
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

                  // Reizen lijst
                  Expanded(
                    child: ListView.builder(
                      itemCount: travels.length,
                      itemBuilder: (context, index) {
                        final travel = travels[index];
                        final travelText = '${travel.emoji} ${travel.name}';
                        final isSelected = selectedTravels.contains(travelText);

                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              final updatedTravels = List<String>.from(
                                selectedTravels,
                              );
                              if (isSelected) {
                                updatedTravels.remove(travelText);
                              } else {
                                updatedTravels.add(travelText);
                              }
                              _updateTravels(updatedTravels);
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
                                  travel.emoji,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    travel.name,
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
