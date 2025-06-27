import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneNumberWidget extends StatefulWidget {
  const PhoneNumberWidget({super.key});

  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  String? phoneNumber;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  // Laad telefoonnummer uit Firebase
  Future<void> _loadPhoneNumber() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore
            .collection('Users')
            .doc(user.uid)
            .collection('gebruiker info')
            .doc('details')
            .get();

        if (doc.exists && doc.data()?['telefoonnummer'] != null) {
          setState(() {
            phoneNumber = doc.data()!['telefoonnummer'];
          });
        }
      }
    } catch (e) {
      print('Error loading phone number: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Sla telefoonnummer op in Firebase
  Future<void> _savePhoneNumber(String? newPhoneNumber) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('Users')
            .doc(user.uid)
            .collection('gebruiker info')
            .doc('details')
            .update({
              'telefoonnummer': newPhoneNumber,
              'bijgewerkt op': FieldValue.serverTimestamp(),
            });

        setState(() {
          phoneNumber = newPhoneNumber;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Telefoonnummer opgeslagen!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      print('Error saving phone number: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fout bij opslaan telefoonnummer'),
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
        // Phone number widget
        GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  _showPhoneNumberModal(context);
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
                      'Telefoonnummer',
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
                    else if (phoneNumber == null)
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
                        '📱 +31 $phoneNumber',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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

  void _showPhoneNumberModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return _PhoneNumberModal(
          currentPhoneNumber: phoneNumber,
          onPhoneNumberChanged: (updatedPhoneNumber) async {
            await _savePhoneNumber(updatedPhoneNumber);
          },
        );
      },
    );
  }
}

class _PhoneNumberModal extends StatefulWidget {
  final String? currentPhoneNumber;
  final Function(String?) onPhoneNumberChanged;

  const _PhoneNumberModal({
    required this.currentPhoneNumber,
    required this.onPhoneNumberChanged,
  });

  @override
  State<_PhoneNumberModal> createState() => _PhoneNumberModalState();
}

class _PhoneNumberModalState extends State<_PhoneNumberModal> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
                  widget.currentPhoneNumber == null
                      ? 'Telefoonnummer toevoegen'
                      : 'Telefoonnummer bijwerken',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onPhoneNumberChanged(
                      _phoneController.text.trim().isEmpty
                          ? widget.currentPhoneNumber
                          : _phoneController.text.trim(),
                    );
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
              widget.currentPhoneNumber == null
                  ? 'Voer je telefoonnummer in'
                  : 'Huidig telefoonnummer:',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            if (widget.currentPhoneNumber != null) ...[
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
                  '📱 +31 ${widget.currentPhoneNumber}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nieuw telefoonnummer:',
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            ],
            const SizedBox(height: 16),
            // Phone number input
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _PhoneNumberFormatter(),
              ],
              decoration: InputDecoration(
                hintText: '6 12 345 678',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixText: '+31 ',
                prefixStyle: const TextStyle(color: Colors.white, fontSize: 16),
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
          ],
        ),
      ),
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.length <= 2) {
      return newValue;
    }

    String formatted = '';
    if (text.isNotEmpty) {
      // Remove any existing formatting
      String digits = text.replaceAll(RegExp(r'[^\d]'), '');

      // Format as: 6 12345678 -> 6 12 345 678
      if (digits.isNotEmpty) {
        formatted = digits[0];
        if (digits.length > 1) {
          formatted +=
              ' ${digits.substring(1, digits.length > 3 ? 3 : digits.length)}';
        }
        if (digits.length > 3) {
          formatted +=
              ' ${digits.substring(3, digits.length > 6 ? 6 : digits.length)}';
        }
        if (digits.length > 6) {
          formatted +=
              ' ${digits.substring(6, digits.length > 9 ? 9 : digits.length)}';
        }
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
