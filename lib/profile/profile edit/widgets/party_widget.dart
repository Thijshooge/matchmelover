import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';

class Party {
  final String name;
  final String emoji;

  Party({required this.name, required this.emoji});
}

class PartyWidget extends StatefulWidget {
  const PartyWidget({super.key});

  @override
  State<PartyWidget> createState() => _PartyWidgetState();
}

class _PartyWidgetState extends State<PartyWidget> {
  List<String> selectedParties = [];
  final ProfileService _profileService = ProfileService();
  bool _isLoading = true;

  final List<Party> parties = [
    Party(name: 'Huisfeestjes', emoji: '🏠'),
    Party(name: 'Clubs/Uitgaan', emoji: '🕺'),
    Party(name: 'Festivals', emoji: '🎪'),
    Party(name: 'Concerten', emoji: '🎵'),
    Party(name: 'Borrels', emoji: '🍻'),
    Party(name: 'Cocktailbars', emoji: '🍸'),
    Party(name: 'Karaoke', emoji: '🎤'),
    Party(name: 'Gamenight', emoji: '🎮'),
    Party(name: 'Barbecue', emoji: '🔥'),
    Party(name: 'Picknick', emoji: '🧺'),
    Party(name: 'Themafeesten', emoji: '🎭'),
    Party(name: 'Dansavonden', emoji: '💃'),
    Party(name: 'Poolparty', emoji: '🏊‍♀️'),
    Party(name: 'Rooftop bars', emoji: '🏙️'),
    Party(name: 'Beach parties', emoji: '🏖️'),
    Party(name: 'Wine tasting', emoji: '🍷'),
    Party(name: 'Brunch parties', emoji: '🥐'),
    Party(name: 'Escape rooms', emoji: '🔐'),
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
          selectedParties = profile?.party?.isNotEmpty == true
              ? profile!.party!.split(',').map((e) => e.trim()).toList()
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

  Future<void> _updateParties(List<String> parties) async {
    setState(() => selectedParties = parties);

    try {
      final partyString = parties.join(', ');
      await _profileService.updateField('party', partyString);
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
        // Party widget
        GestureDetector(
          onTap: () {
            _showPartySelection(context);
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
                      'Feesten & Uitgaan',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    if (selectedParties.isEmpty)
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
                          _updateParties([]);
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
                if (selectedParties.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedParties.map((party) {
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
                              party,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                final updatedParties = List<String>.from(
                                  selectedParties,
                                );
                                updatedParties.remove(party);
                                _updateParties(updatedParties);
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

  void _showPartySelection(BuildContext context) {
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
                        'Selecteer je feest voorkeuren',
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
                    'Kies waar je van houdt om naartoe te gaan',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  // Feesten lijst
                  Expanded(
                    child: ListView.builder(
                      itemCount: parties.length,
                      itemBuilder: (context, index) {
                        final party = parties[index];
                        final partyText = '${party.emoji} ${party.name}';
                        final isSelected = selectedParties.contains(partyText);

                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              final updatedParties = List<String>.from(
                                selectedParties,
                              );
                              if (isSelected) {
                                updatedParties.remove(partyText);
                              } else {
                                updatedParties.add(partyText);
                              }
                              _updateParties(updatedParties);
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
                                  party.emoji,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    party.name,
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
