import 'package:flutter/material.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  // Dummy data voor mensen die jou hebben geliked
  final List<Map<String, dynamic>> _likedProfiles = [
    {
      'name': 'Emma',
      'age': 24,
      'image':
          'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=400',
      'distance': '2 km',
      'bio': 'Love traveling and good coffee ☕',
    },
    {
      'name': 'Sophie',
      'age': 26,
      'image':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
      'distance': '5 km',
      'bio': 'Yoga instructor & nature lover 🧘‍♀️',
    },
    {
      'name': 'Lisa',
      'age': 23,
      'image':
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
      'distance': '3 km',
      'bio': 'Artist and dog lover 🎨🐕',
    },
    {
      'name': 'Anna',
      'age': 28,
      'image':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400',
      'distance': '7 km',
      'bio': 'Foodie & adventure seeker 🍕',
    },
    {
      'name': 'Maria',
      'age': 25,
      'image':
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400',
      'distance': '4 km',
      'bio': 'Photographer & music lover 📸🎵',
    },
    {
      'name': 'Julia',
      'age': 27,
      'image':
          'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=400',
      'distance': '6 km',
      'bio': 'Fitness enthusiast & bookworm 💪📚',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45,
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
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
              'LIKES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(horizontal: 4),
            constraints: BoxConstraints(),
            icon: Icon(Icons.search, size: 24),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header sectie
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_likedProfiles.length} mensen vinden jou leuk',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Like ze terug om een match te maken!',
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Grid met profiel cards
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _likedProfiles.length,
                itemBuilder: (context, index) {
                  final profile = _likedProfiles[index];
                  return _buildProfileCard(context, profile, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    Map<String, dynamic> profile,
    int index,
  ) {
    return GestureDetector(
      onTap: () => _showProfileDetail(context, profile),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Achtergrond foto
              Image.network(
                profile['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.5),
                    ),
                  );
                },
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),

              // Profiel info
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${profile['name']}, ${profile['age']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile['distance'],
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Like indicator
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfileDetail(BuildContext context, Map<String, dynamic> profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Grote foto
                      Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(profile['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Naam en leeftijd
                      Text(
                        '${profile['name']}, ${profile['age']}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Afstand
                      Text(
                        profile['distance'],
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.surface.withValues(alpha: 0.7),
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Bio
                      Text(
                        'Bio',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        profile['bio'],
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.surface.withValues(alpha: 0.8),
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Action buttons
                      Row(
                        children: [
                          // Pass button
                          Expanded(
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surface.withValues(alpha: 0.3),
                                ),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _removeProfile(profile);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                label: Text(
                                  'Pass',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Like button
                          Expanded(
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _likeProfile(profile);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Like',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeProfile(Map<String, dynamic> profile) {
    setState(() {
      _likedProfiles.remove(profile);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${profile['name']} gepasseerd'),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.surface.withValues(alpha: 0.9),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _likeProfile(Map<String, dynamic> profile) {
    setState(() {
      _likedProfiles.remove(profile);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 Match met ${profile['name']}!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
