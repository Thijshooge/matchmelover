import 'package:flutter/material.dart';
import 'dart:io';
import '../../../services/photo_service.dart';
import 'photo_slot_widget.dart';

class PhotoGridWidget extends StatefulWidget {
  const PhotoGridWidget({super.key});

  @override
  State<PhotoGridWidget> createState() => _PhotoGridWidgetState();
}

class _PhotoGridWidgetState extends State<PhotoGridWidget> {
  final PhotoService _photoService = PhotoService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Test storage connection bij opstarten
    _photoService.testStorageConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),

        if (_isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          ),

        // StreamBuilder voor realtime foto updates
        StreamBuilder<List<String?>>(
          stream: _photoService.getPhotos(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final photos = snapshot.data ?? List.filled(9, null);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return PhotoSlotWidget(
                  index: index,
                  photoPath: photos[index],
                  onPhotoSelected: (photoPath) =>
                      _updatePhoto(index, photoPath),
                  onMultiplePhotosSelected: _addMultiplePhotos,
                  onReorder: _reorderPhotos,
                );
              },
            );
          },
        ),
      ],
    );
  }

  // Update een enkele foto
  Future<void> _updatePhoto(int index, String? photoPath) async {
    if (photoPath == null) {
      // Verwijder foto
      try {
        await _photoService.deletePhoto(index);
      } catch (e) {
        _showErrorSnackBar('Fout bij verwijderen foto: $e');
      }
    } else {
      // Upload nieuwe foto
      try {
        setState(() => _isLoading = true);
        final imageFile = File(photoPath);
        await _photoService.uploadPhoto(imageFile, index);
        setState(() => _isLoading = false);
      } catch (e) {
        setState(() => _isLoading = false);
        _showErrorSnackBar('Fout bij uploaden foto: $e');
      }
    }
  }

  // Voeg meerdere foto's toe
  Future<void> _addMultiplePhotos(List<String> photoPaths) async {
    try {
      setState(() => _isLoading = true);

      // Vind eerste lege plekken via de stream
      final currentPhotos = await _photoService.getPhotos().first;

      int currentIndex = 0;
      for (String photoPath in photoPaths) {
        // Zoek volgende lege plek
        while (currentIndex < 9 && currentPhotos[currentIndex] != null) {
          currentIndex++;
        }

        if (currentIndex < 9) {
          final imageFile = File(photoPath);
          // Upload elke foto individueel naar de specifieke index
          await _photoService.uploadPhoto(imageFile, currentIndex);
          currentIndex++;
        }
      }

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Fout bij uploaden foto\'s: $e');
    }
  }

  // Herorder foto's (wissel twee posities om)
  Future<void> _reorderPhotos(int fromIndex, int toIndex) async {
    try {
      await _photoService.reorderPhotos(fromIndex, toIndex);
    } catch (e) {
      _showErrorSnackBar('Fout bij herordenen foto\'s: $e');
    }
  }

  // Helper methode voor error messages
  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }
}
