import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config/api_config.dart';
import '../../../services/profile_service.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class PlaceResult {
  final String placeId;
  final String description;
  final String? lat;
  final String? lng;

  PlaceResult({
    required this.placeId,
    required this.description,
    this.lat,
    this.lng,
  });

  factory PlaceResult.fromJson(Map<String, dynamic> json) {
    return PlaceResult(
      placeId: json['place_id'],
      description: json['description'],
    );
  }
}

class _LocationWidgetState extends State<LocationWidget> {
  String? selectedLocation;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  List<PlaceResult> searchResults = [];
  bool isLoading = false;
  final ProfileService _profileService = ProfileService();
  bool _isLoadingProfile = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final uid = _profileService.currentUserId;
    if (uid == null) {
      setState(() => _isLoadingProfile = false);
      return;
    }

    try {
      final profile = await _profileService.getProfile(uid);
      if (profile == null) {
        await _profileService.createProfile(uid);
      }
      if (mounted) {
        setState(() {
          selectedLocation = profile?.location;
          _isLoadingProfile = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingProfile = false);
      }
    }
  }

  Future<void> _updateLocation(String location) async {
    setState(() => selectedLocation = location.isEmpty ? null : location);

    try {
      await _profileService.updateField('location', location);
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

  Future<List<PlaceResult>> searchPlaces(String query) async {
    if (query.isEmpty) return [];

    // Check of API key is geconfigureerd
    if (!ApiConfig.isApiKeyConfigured) {
      print('Google Places API key is niet geconfigureerd');
      return [];
    }

    final String url =
        '${ApiConfig.googlePlacesBaseUrl}/autocomplete/json'
        '?input=${Uri.encodeComponent(query)}'
        '&types=(cities)'
        '&key=${ApiConfig.googlePlacesApiKey}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final predictions = data['predictions'] as List;

        return predictions
            .map((prediction) => PlaceResult.fromJson(prediction))
            .toList();
      }
    } catch (e) {
      print('Error searching places: $e');
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingProfile) {
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
            _showLocationSelection(context);
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
                  'Woonplaats',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                if (selectedLocation == null)
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
                      Flexible(
                        child: Text(
                          selectedLocation!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _updateLocation('');
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

  void _showLocationSelection(BuildContext context) {
    _searchController.clear();
    searchQuery = '';
    searchResults = [];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selecteer je woonplaats',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Zoekbalk
                  TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Zoek een plaats wereldwijd...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                setModalState(() {
                                  searchQuery = '';
                                  searchResults = [];
                                });
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) async {
                      setModalState(() {
                        searchQuery = value;
                        isLoading = true;
                      });

                      if (value.isNotEmpty) {
                        final results = await searchPlaces(value);
                        setModalState(() {
                          searchResults = results;
                          isLoading = false;
                        });
                      } else {
                        setModalState(() {
                          searchResults = [];
                          isLoading = false;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  // Instructies
                  if (searchQuery.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 48,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Begin met typen om te zoeken naar\nelle steden wereldwijd',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  // Loading indicator
                  else if (isLoading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    )
                  // Resultaten lijst
                  else if (searchResults.isEmpty && searchQuery.isNotEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Geen plaatsen gevonden',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final place = searchResults[index];
                          return GestureDetector(
                            onTap: () {
                              _updateLocation(place.description);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      place.description,
                                      style: TextStyle(
                                        color:
                                            selectedLocation ==
                                                place.description
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                            : Colors.white,
                                        fontSize: 16,
                                        fontWeight:
                                            selectedLocation ==
                                                place.description
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
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
