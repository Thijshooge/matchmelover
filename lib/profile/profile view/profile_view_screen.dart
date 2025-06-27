import 'package:flutter/material.dart';
import '../../services/profile_service.dart';
import '../../services/photo_service.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  final ProfileService _profileService = ProfileService();
  final PhotoService _photoService = PhotoService();
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;
  int _currentPhotoIndex = 0;
  final PageController _pageController = PageController();

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
          _profileData = profile?.toMap();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<String> _getPhotosFromStream(List<String?> photoStream) {
    List<String> photos = [];
    for (String? photoUrl in photoStream) {
      if (photoUrl != null && photoUrl.isNotEmpty) {
        photos.add(photoUrl);
      }
    }
    return photos;
  }

  String? _getProfilePhoto(List<String?> photoStream) {
    // Return the first photo that exists (index 0)
    if (photoStream.isNotEmpty &&
        photoStream[0] != null &&
        photoStream[0]!.isNotEmpty) {
      return photoStream[0];
    }
    // If no photo at index 0, return first available photo
    for (String? photoUrl in photoStream) {
      if (photoUrl != null && photoUrl.isNotEmpty) {
        return photoUrl;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _profileService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        appBar: AppBar(
          toolbarHeight: 45.0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          title: const Text('Profile View'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Gereed',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45.0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: const Text('Profile View'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Gereed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),

      body: StreamBuilder<List<String?>>(
        stream: _photoService.getPhotos(),
        builder: (context, photoSnapshot) {
          if (photoSnapshot.hasError) {
            return Center(
              child: Text('Error loading photos: ${photoSnapshot.error}'),
            );
          }

          final photos = _getPhotosFromStream(photoSnapshot.data ?? []);
          final profilePhoto = _getProfilePhoto(photoSnapshot.data ?? []);

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // All Photos Carousel (if photos available)
                if (photos.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10,
                    ),
                    child: Text(
                      'Alle foto\'s',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: 400,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to next photo on tap
                            if (photos.length > 1) {
                              final nextIndex =
                                  (_currentPhotoIndex + 1) % photos.length;
                              _pageController.animateToPage(
                                nextIndex,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() => _currentPhotoIndex = index);
                            },
                            itemCount: photos.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(photos[index]),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // Photo indicators
                        if (photos.length > 1)
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${_currentPhotoIndex + 1}/${photos.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        // Dots indicator at bottom
                        if (photos.length > 1)
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  photos.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentPhotoIndex == index
                                          ? Colors.white
                                          : Colors.white.withValues(alpha: 0.4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],

                // No photos placeholder (only show if no photos at all)
                if (photos.isEmpty) ...[
                  Container(
                    height: 200,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 1),
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.1),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera_outlined,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Geen foto\'s toegevoegd',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                // Profile Info
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bio Section
                      if (_hasValue('bio')) ...[
                        Text(
                          'Bio',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildInfoDisplay(_profileData!['bio']),
                        const SizedBox(height: 20),
                      ],

                      // Over mij Section
                      if (_hasValue('gender') || _hasValue('location')) ...[
                        Text(
                          'Over mij',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_hasValue('gender'))
                          _buildInfoRow('Gender', _profileData!['gender']),
                        if (_hasValue('location'))
                          _buildInfoRow(
                            'Woonplaats',
                            _profileData!['location'],
                          ),
                        const SizedBox(height: 20),
                      ],

                      // Meer over mij Section
                      if (_hasAnyValue([
                        'zodiac',
                        'sport',
                        'party',
                        'travel',
                        'height',
                      ])) ...[
                        Text(
                          'Meer over mij',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_hasValue('zodiac'))
                          _buildInfoRow(
                            'Sterrenbeeld',
                            _profileData!['zodiac'],
                          ),
                        if (_hasValue('sport'))
                          _buildInfoRow('Sport', _profileData!['sport']),
                        if (_hasValue('party'))
                          _buildInfoRow('Uitgaan', _profileData!['party']),
                        if (_hasValue('travel'))
                          _buildInfoRow('Reizen', _profileData!['travel']),
                        if (_hasValue('height'))
                          _buildInfoRow('Lengte', _profileData!['height']),
                        const SizedBox(height: 20),
                      ],

                      // Nog meer over mij Section
                      if (_hasAnyValue([
                        'looking_for',
                        'smoking',
                        'language',
                      ])) ...[
                        Text(
                          'Nog meer over mij',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_hasValue('looking_for'))
                          _buildInfoRow(
                            'Zoekt naar',
                            _profileData!['looking_for'],
                          ),
                        if (_hasValue('smoking'))
                          _buildInfoRow('Roken', _profileData!['smoking']),
                        if (_hasValue('language'))
                          _buildInfoRow('Taal', _profileData!['language']),
                        const SizedBox(height: 40),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _hasValue(String key) {
    return _profileData != null &&
        _profileData![key] != null &&
        _profileData![key].toString().isNotEmpty;
  }

  bool _hasAnyValue(List<String> keys) {
    return keys.any((key) => _hasValue(key));
  }

  Widget _buildInfoRow(String label, dynamic value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1),
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            value.toString(),
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoDisplay(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1),
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
      ),
    );
  }
}
