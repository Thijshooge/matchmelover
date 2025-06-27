import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';
import '../../../models/profile_model.dart';

class BioWidget extends StatefulWidget {
  const BioWidget({super.key});

  @override
  State<BioWidget> createState() => _BioWidgetState();
}

class _BioWidgetState extends State<BioWidget> {
  final TextEditingController _bioController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ProfileService _profileService = ProfileService();

  static const int maxBioLength = 500;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // Update border color when focus changes
    });
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final uid = _profileService.currentUserId;
    if (uid == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      // Probeer bestaand profiel te laden
      ProfileModel? profile = await _profileService.getProfile(uid);

      // Als geen profiel bestaat, maak nieuwe aan
      profile ??= await _profileService.createProfile(uid);

      if (mounted) {
        setState(() {
          _bioController.text = profile!.bio ?? '';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Fout bij laden profiel: $e')));
      }
    }
  }

  void _onBioChanged(String value) {
    setState(() => _isSaving = true);

    // Auto-save met debouncing
    _profileService.updateBio(value);

    // Reset saving indicator na 3 seconden
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) setState(() => _isSaving = false);
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    _focusNode.dispose();
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

    final remainingChars = maxBioLength - _bioController.text.length;
    final isOverLimit = remainingChars < 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField styled like MyTextField
            TextField(
              controller: _bioController,
              focusNode: _focusNode,
              maxLines: 4,
              minLines: 1,
              onChanged: (value) {
                setState(() {}); // Update character count
                _onBioChanged(value); // Auto-save
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.4,
              ),
              decoration: InputDecoration(
                hintText: 'Vertel iets over jezelf...',
                hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                suffixIcon: _bioController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _bioController.clear();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 236, 28, 36),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isOverLimit)
                  const Text(
                    'Te veel karakters',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  )
                else if (_isSaving)
                  Row(
                    children: [
                      SizedBox(
                        height: 12,
                        width: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Opslaan...',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  )
                else
                  const SizedBox(),
                Text(
                  '${_bioController.text.length}/$maxBioLength',
                  style: TextStyle(
                    color: isOverLimit ? Colors.red : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
