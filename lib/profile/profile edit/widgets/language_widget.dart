import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';

class Language {
  final String name;
  final String emoji;

  Language({required this.name, required this.emoji});
}

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  List<String> selectedLanguages = [];
  final ProfileService _profileService = ProfileService();
  bool _isLoading = true;

  final List<Language> languages = [
    // Europa
    Language(name: 'Nederlands', emoji: '🇳🇱'),
    Language(name: 'Engels', emoji: '🇺🇸'),
    Language(name: 'Duits', emoji: '🇩🇪'),
    Language(name: 'Frans', emoji: '🇫🇷'),
    Language(name: 'Spaans', emoji: '🇪🇸'),
    Language(name: 'Italiaans', emoji: '🇮🇹'),
    Language(name: 'Portugees', emoji: '🇵🇹'),
    Language(name: 'Russisch', emoji: '🇷🇺'),
    Language(name: 'Pools', emoji: '🇵🇱'),
    Language(name: 'Zweeds', emoji: '🇸🇪'),
    Language(name: 'Noors', emoji: '��'),
    Language(name: 'Deens', emoji: '�🇰'),
    Language(name: 'Fins', emoji: '�🇮'),
    Language(name: 'Grieks', emoji: '��'),
    Language(name: 'Turks', emoji: '��'),
    // Azië
    Language(name: 'Chinees (Mandarijn)', emoji: '🇨🇳'),
    Language(name: 'Chinees (Kantonees)', emoji: '🇭🇰'),
    Language(name: 'Japans', emoji: '🇯🇵'),
    Language(name: 'Koreaans', emoji: '🇰🇷'),
    Language(name: 'Hindi', emoji: '🇮🇳'),
    Language(name: 'Arabisch', emoji: '��'),
    Language(name: 'Thai', emoji: '�🇭'),
    Language(name: 'Vietnamees', emoji: '�🇳'),
    Language(name: 'Indonesisch', emoji: '🇮�'),
    Language(name: 'Maleis', emoji: '��'),
    // Afrika
    Language(name: 'Swahili', emoji: '🇰🇪'),
    Language(name: 'Afrikaans', emoji: '🇿🇦'),
    // Amerika
    Language(name: 'Spaans (Latijns-Amerika)', emoji: '🇲🇽'),
    Language(name: 'Portugees (Braziliaans)', emoji: '🇧🇷'),
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
          selectedLanguages = profile?.language?.isNotEmpty == true
              ? profile!.language!.split(',').map((e) => e.trim()).toList()
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

  Future<void> _updateLanguages(List<String> languages) async {
    setState(() => selectedLanguages = languages);

    try {
      final languageString = languages.join(', ');
      await _profileService.updateField('language', languageString);
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
        // Language widget
        GestureDetector(
          onTap: () {
            _showLanguageSelection(context);
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
                      'Talen',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    if (selectedLanguages.isEmpty)
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
                          _updateLanguages([]);
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
                if (selectedLanguages.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedLanguages.map((language) {
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
                              language,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                final updatedLanguages = List<String>.from(
                                  selectedLanguages,
                                );
                                updatedLanguages.remove(language);
                                _updateLanguages(updatedLanguages);
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

  void _showLanguageSelection(BuildContext context) {
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
                        'Selecteer je talen',
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
                    'Je kunt meerdere talen selecteren',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  // Talen lijst
                  Expanded(
                    child: ListView.builder(
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final language = languages[index];
                        final languageText =
                            '${language.emoji} ${language.name}';
                        final isSelected = selectedLanguages.contains(
                          languageText,
                        );

                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              final updatedLanguages = List<String>.from(
                                selectedLanguages,
                              );
                              if (isSelected) {
                                updatedLanguages.remove(languageText);
                              } else {
                                updatedLanguages.add(languageText);
                              }
                              _updateLanguages(updatedLanguages);
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
                                  language.emoji,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    language.name,
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
