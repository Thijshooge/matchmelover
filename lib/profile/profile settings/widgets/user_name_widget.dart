import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserNameWidget extends StatefulWidget {
  const UserNameWidget({super.key});

  @override
  State<UserNameWidget> createState() => _UserNameWidgetState();
}

class _UserNameWidgetState extends State<UserNameWidget> {
  String? userName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  // Laad gebruikersnaam uit Firebase
  Future<void> _loadUserName() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore
            .collection('Users')
            .doc(user.uid)
            .collection('gebruiker info')
            .doc('details')
            .get();

        if (doc.exists && doc.data()?['gebruikersnaam'] != null) {
          setState(() {
            userName = doc.data()!['gebruikersnaam'];
          });
        }
      }
    } catch (e) {
      print('Error loading user name: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Sla gebruikersnaam op in Firebase
  Future<void> _saveUserName(String? newUserName) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('Users')
            .doc(user.uid)
            .collection('gebruiker info')
            .doc('details')
            .update({
              'gebruikersnaam': newUserName,
              'bijgewerkt op': FieldValue.serverTimestamp(),
            });

        setState(() {
          userName = newUserName;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gebruikersnaam opgeslagen!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      print('Error saving user name: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fout bij opslaan gebruikersnaam'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // User name widget
        GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  _showUserNameModal(context);
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
                      'Gebruikersnaam',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    if (isLoading)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    else if (userName == null)
                      const Text(
                        'Toevoegen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    else
                      Text(
                        '👤 $userName',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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

  void _showUserNameModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return _UserNameModal(
          currentUserName: userName,
          onUserNameChanged: (updatedUserName) async {
            await _saveUserName(updatedUserName);
          },
        );
      },
    );
  }
}

class _UserNameModal extends StatefulWidget {
  final String? currentUserName;
  final Function(String?) onUserNameChanged;

  const _UserNameModal({
    required this.currentUserName,
    required this.onUserNameChanged,
  });

  @override
  State<_UserNameModal> createState() => _UserNameModalState();
}

class _UserNameModalState extends State<_UserNameModal> {
  late TextEditingController _userNameController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.currentUserName == null
                      ? 'Gebruikersnaam toevoegen'
                      : 'Gebruikersnaam bijwerken',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final newUserName = _userNameController.text.trim();
                    if (newUserName.isNotEmpty) {
                      widget.onUserNameChanged(newUserName);
                    } else if (widget.currentUserName != null) {
                      // Behoud huidige gebruikersnaam als er geen nieuwe is ingevuld
                      widget.onUserNameChanged(widget.currentUserName);
                    }
                    // Als er geen tekst EN geen huidige gebruikersnaam is, doe dan niets
                    Navigator.pop(context);
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
            const SizedBox(height: 16),
            Text(
              widget.currentUserName == null
                  ? 'Voer je gebruikersnaam in'
                  : 'Huidige gebruikersnaam:',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            if (widget.currentUserName != null) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[600]!, width: 1),
                  color: Colors.grey[800],
                ),
                child: Text(
                  '👤 ${widget.currentUserName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nieuwe gebruikersnaam:',
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            ],
            const SizedBox(height: 16),
            // User name input
            TextField(
              controller: _userNameController,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.white),
              autofocus: true,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
              ],
              decoration: InputDecoration(
                hintText: 'Gebruikersnaam',
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Maximaal 20 tekens. Alleen letters, cijfers en underscore.',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
