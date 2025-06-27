import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoSlotWidget extends StatelessWidget {
  final int index;
  final String? photoPath;
  final Function(String?) onPhotoSelected;
  final Function(List<String>)? onMultiplePhotosSelected;
  final Function(int, int)? onReorder;

  const PhotoSlotWidget({
    super.key,
    required this.index,
    required this.photoPath,
    required this.onPhotoSelected,
    this.onMultiplePhotosSelected,
    this.onReorder,
  });

  bool _isUrl(String? path) {
    return path != null &&
        (path.startsWith('http://') || path.startsWith('https://'));
  }

  Widget _buildImage(String photoPath, {double? width, double? height}) {
    if (_isUrl(photoPath)) {
      return Image.network(
        photoPath,
        fit: BoxFit.cover,
        width: width,
        height: height,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.error, color: Colors.red));
        },
      );
    } else {
      return Image.file(
        File(photoPath),
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    }
  }

  Future<void> _showPhotoOptions(BuildContext context) async {
    if (photoPath != null) {
      // Als er al een foto is, toon verwijderen/wijzigen opties
      final result = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Foto opties'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Foto wijzigen'),
                onTap: () => Navigator.pop(context, 'change'),
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Foto verwijderen'),
                onTap: () => Navigator.pop(context, 'delete'),
              ),
            ],
          ),
        ),
      );

      if (result == 'delete') {
        onPhotoSelected(null);
      } else if (result == 'change') {
        if (context.mounted) {
          await _showImageSourceOptions(context);
        }
      }
    } else {
      // Als er geen foto is, toon direct camera/bibliotheek opties
      if (context.mounted) {
        await _showImageSourceOptions(context);
      }
    }
  }

  Future<void> _showImageSourceOptions(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,

      builder: (context) => AlertDialog(
        title: const Text('Foto toevoegen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Foto maken'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Kies uit bibliotheek'),
              onTap: () => Navigator.pop(context, 'gallery_multiple'),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      if (result == 'gallery_multiple') {
        await _pickMultipleImages();
      } else {
        await _pickImage(result as ImageSource);
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        onPhotoSelected(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _pickMultipleImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();

      if (images.isNotEmpty && onMultiplePhotosSelected != null) {
        final List<String> imagePaths = images
            .map((image) => image.path)
            .toList();
        onMultiplePhotosSelected!(imagePaths);
      }
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onAcceptWithDetails: (details) {
        if (onReorder != null) {
          onReorder!(details.data, index);
        }
      },
      builder: (context, candidateData, rejectedData) {
        bool isHovering = candidateData.isNotEmpty;
        return LongPressDraggable<int>(
          data: index,
          delay: const Duration(
            milliseconds: 100,
          ), // Snelle reactie voor drag & drop
          feedback: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: photoPath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _buildImage(photoPath!, width: 100, height: 100),
                    )
                  : const Icon(Icons.photo, size: 40),
            ),
          ),
          child: GestureDetector(
            onTap: () => _showPhotoOptions(context),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: isHovering
                    ? Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1)
                    : Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isHovering
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.3),
                  width: isHovering ? 2 : 1,
                ),
              ),
              child: photoPath != null
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildImage(
                            photoPath!,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => onPhotoSelected(null),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          color: Theme.of(
                            context,
                          ).colorScheme.surface.withValues(alpha: 0.6),
                          size: 32,
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
