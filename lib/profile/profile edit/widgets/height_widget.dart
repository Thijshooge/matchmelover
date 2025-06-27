import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../services/profile_service.dart';

class HeightWidget extends StatefulWidget {
  const HeightWidget({super.key});

  @override
  State<HeightWidget> createState() => _HeightWidgetState();
}

class _HeightWidgetState extends State<HeightWidget> {
  int? selectedHeight;
  final ProfileService _profileService = ProfileService();
  bool _isLoading = true;

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
          selectedHeight = profile?.height;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateHeight(int? height) async {
    setState(() => selectedHeight = height);

    try {
      await _profileService.updateField('height', height);
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
        // Height widget
        GestureDetector(
          onTap: () {
            _showHeightSelection(context);
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
                  'Lengte',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                if (selectedHeight == null)
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
                      Text(
                        '📏 $selectedHeight cm',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _updateHeight(null);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
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

  void _showHeightSelection(BuildContext context) {
    int tempSelectedHeight =
        selectedHeight ?? 170; // Start with 170cm as default
    int selectedIndex = tempSelectedHeight - 100; // Track selected index

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
              height: MediaQuery.of(modalContext).size.height * 0.6,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selecteer je lengte',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _updateHeight(tempSelectedHeight);
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
                  const SizedBox(height: 20),
                  // Height picker
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.1),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: CupertinoPicker(
                        backgroundColor: Colors.transparent,
                        itemExtent: 50,
                        scrollController: FixedExtentScrollController(
                          initialItem:
                              tempSelectedHeight -
                              100, // Start at the selected height
                        ),
                        onSelectedItemChanged: (int index) {
                          setModalState(() {
                            tempSelectedHeight = 100 + index; // 100cm + index
                            selectedIndex = index;
                          });
                        },
                        children: List<Widget>.generate(131, (int index) {
                          final height =
                              100 + index; // Heights from 100cm to 230cm
                          final bool isSelected = index == selectedIndex;
                          return Center(
                            child: Text(
                              '$height cm',
                              style: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      // Update the temp selection when modal is dismissed without pressing "Klaar"
      if (mounted) {
        setState(() {
          // Keep the current selection if modal was dismissed
        });
      }
    });
  }
}
