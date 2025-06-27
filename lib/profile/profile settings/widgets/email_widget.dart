import 'package:flutter/material.dart';

class EmailWidget extends StatefulWidget {
  final String? initialEmail;

  const EmailWidget({super.key, this.initialEmail});

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  String? email;

  @override
  Widget build(BuildContext context) {
    // Gebruik initialEmail of de lokale email state
    String? displayEmail = email ?? widget.initialEmail;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // Email widget
        GestureDetector(
          onTap: () {
            _showEmailModal(context, displayEmail);
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
                      'E-mailadres',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    if (displayEmail == null || displayEmail.isEmpty)
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
                        '📧 $displayEmail',
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

  void _showEmailModal(BuildContext context, String? currentEmail) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return _EmailModal(
          currentEmail: currentEmail,
          onEmailChanged: (updatedEmail) {
            // Hier zou je normaal de email in de database updaten
            // Voor nu laten we het zoals het is
            setState(() {
              email = updatedEmail;
            });
          },
        );
      },
    );
  }
}

class _EmailModal extends StatefulWidget {
  final String? currentEmail;
  final Function(String?) onEmailChanged;

  const _EmailModal({required this.currentEmail, required this.onEmailChanged});

  @override
  State<_EmailModal> createState() => _EmailModalState();
}

class _EmailModalState extends State<_EmailModal> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                  widget.currentEmail == null
                      ? 'E-mailadres toevoegen'
                      : 'E-mailadres bijwerken',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onEmailChanged(
                      _emailController.text.trim().isEmpty
                          ? widget.currentEmail
                          : _emailController.text.trim(),
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
              widget.currentEmail == null
                  ? 'Voer je e-mailadres in'
                  : 'Huidig e-mailadres:',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            if (widget.currentEmail != null) ...[
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
                  '📧 ${widget.currentEmail}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nieuw e-mailadres:',
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            ],
            const SizedBox(height: 16),
            // Email input
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'naam@voorbeeld.nl',
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
              'Voer een geldig e-mailadres in',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
