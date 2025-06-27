import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchme_lover/profile/profile%20info/widgets/abbonement/abbonement_widget.dart';
import 'dart:async';
import '../services/photo_service.dart';
import 'profile info/widgets/prestaties/prestaties_widget.dart';
import 'profile info/widgets/ontdek/ontdek_meer_widget.dart';
import 'profile info/widgets/privacy/privacy_beveiliging_widget.dart';

import 'profile info/widgets/veiligheid/veiligheid_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  final PhotoService _photoService = PhotoService();
  StreamSubscription<List<String?>>? _photoSubscription;
  String? userName;
  int? userAge;
  String? userEmail;
  String? profileImageUrl;
  bool isLoading = true;
  int selectedTabIndex = 0; // Voor het bijhouden van welke tab actief is

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadUserData();
    _startPhotoStream();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _photoSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      debugPrint('📱 App resumed - checking for photo updates');
      // Stream zou automatisch moeten updaten, maar we loggen het
    }
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Haal alleen profieldata op - foto's komen via stream
        final profileData = await _loadProfileData(user);

        setState(() {
          userName = profileData?['naam'] ?? 'Onbekende gebruiker';
          userAge = profileData?['leeftijd'] ?? 0;
          userEmail = user.email;
          isLoading = false;
        });

        debugPrint('🎯 Profile data loaded - Name: $userName');
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
      setState(() {
        userName = 'Fout bij laden';
        userAge = 0;
        isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>?> _loadProfileData(User user) async {
    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('gebruiker info')
        .doc('details')
        .get();

    return doc.exists ? doc.data() : null;
  }

  void _startPhotoStream() {
    debugPrint('🔍 Starting photo stream...');
    _photoSubscription = _photoService.getPhotos().listen(
      (photos) {
        debugPrint('📸 Photos stream update: ${photos.length} items');

        // Debug: Print alle foto's
        for (int i = 0; i < photos.length; i++) {
          if (photos[i] != null) {
            debugPrint('📸 Photo $i: ${photos[i]}');
          }
        }

        // Zoek de eerste foto die niet null is
        String? firstPhoto;
        for (int i = 0; i < photos.length; i++) {
          if (photos[i] != null && photos[i]!.isNotEmpty) {
            firstPhoto = photos[i];
            debugPrint('✅ Found first photo at index $i: $firstPhoto');
            break;
          }
        }

        // Update de UI als de foto is veranderd
        if (profileImageUrl != firstPhoto) {
          setState(() {
            profileImageUrl = firstPhoto;
          });
          debugPrint(
            '🎯 Profile photo updated from "$profileImageUrl" to "$firstPhoto"',
          );
        } else {
          debugPrint('🔄 Photo unchanged: $firstPhoto');
        }
      },
      onError: (error) {
        debugPrint('💥 Photo stream error: $error');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // Logo links
            Image.asset(
              'assets/logo.png',
              height: 32,
              width: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            // Tekst naast logo
            Text(
              'PROFIEL',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/matchme/profile_view',
                arguments: {'email': userEmail},
              );
            },
            padding: EdgeInsets.symmetric(horizontal: 4),
            constraints: BoxConstraints(),
            icon: Icon(Icons.visibility, size: 24),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/matchme/profile_settings',
                arguments: {'email': userEmail},
              );
            },
            padding: EdgeInsets.symmetric(horizontal: 4),
            constraints: BoxConstraints(),
            icon: Icon(Icons.settings_outlined, size: 24),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: [
            const SizedBox(height: 0),

            // Loading indicator of profiel data
            if (isLoading)
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              )
            else ...[
              // Profiel sectie - foto, naam/leeftijd en buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profielfoto (kleiner) - klikbaar
                    GestureDetector(
                      onTap: () => _showProfilePopup(context),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1,
                          ),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: profileImageUrl != null
                            ? ClipOval(
                                child: Image.network(
                                  profileImageUrl!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 50,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Naam en leeftijd sectie
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Naam met leeftijd achter elkaar
                          Row(
                            children: [
                              Text(
                                userName ?? 'Onbekende gebruiker',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                userAge != null && userAge! > 0
                                    ? '$userAge'
                                    : '?',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Profile buttons in een horizontale scrollable lijst
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                height: 40, // Nog minder hoog
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProfileButton(
                      context,
                      'Mijn prestaties',
                      Icons.analytics_outlined,
                      0,
                    ),
                    const SizedBox(width: 12),
                    _buildProfileButton(
                      context,
                      'Ontdek meer',
                      Icons.explore_outlined,
                      1,
                    ),
                    const SizedBox(width: 12),
                    _buildProfileButton(
                      context,
                      'Veiligheid',
                      Icons.security_outlined,
                      2,
                    ),
                    const SizedBox(width: 12),
                    _buildProfileButton(
                      context,
                      'Abbonement',
                      Icons.card_membership_outlined,
                      3,
                    ),
                    const SizedBox(width: 12),
                    _buildProfileButton(
                      context,
                      'Beveiliging en privacy',
                      Icons.privacy_tip_outlined,
                      4,
                    ),
                    // Je kunt hier meer buttons toevoegen
                    const SizedBox(width: 12), // Extra ruimte aan het einde
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Content area based on selected tab
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildTabContent(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileButton(
    BuildContext context,
    String text,
    IconData icon,
    int index,
  ) {
    bool isSelected = selectedTabIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        elevation: 1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.surface,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.surface,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0: // Mijn prestaties
        return const PrestatiesWidget();
      case 1: // Ontdek meer
        return const OntdekMeerWidget();
      case 2: // Veiligheid
        return const VeiligheidWidget();
      case 3: // Abbonement
        const AbbonementWidget();
        return const AbbonementWidget();
      case 4: // Beveiliging en privacy

        return const PrivacyBeveiligingWidget(); // Hier kun je een andere widget voor beveiliging en privacy plaatsen
      default:
        return const PrestatiesWidget();
    }
  }

  void _showProfilePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Grote profielfoto
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: profileImageUrl != null
                      ? ClipOval(
                          child: Image.network(
                            profileImageUrl!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                size: 80,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 80,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                ),

                const SizedBox(height: 20),

                // Naam met leeftijd
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName ?? 'Onbekende gebruiker',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      userAge != null && userAge! > 0 ? '$userAge' : '?',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Profiel bewerken tekst
                Text(
                  'Profiel bewerken',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 30),

                // Profiel bewerken button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(); // Sluit popup
                      Navigator.pushNamed(context, '/matchme/profile_edit');
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Profiel bewerken'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
