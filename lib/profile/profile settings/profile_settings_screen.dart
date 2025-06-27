import 'package:flutter/material.dart';

import 'widgets/email_widget.dart';
import 'widgets/user_name_widget.dart';
import 'widgets/phone_number_widget.dart';
import 'widgets/security_widget.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Haal email op uit route arguments
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? userEmail = arguments?['email'];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45.0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
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
        title: const Text('Profile Settings'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(color: Theme.of(context).colorScheme.surface),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account instellingen',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const PhoneNumberWidget(),
                  const UserNameWidget(),
                  EmailWidget(initialEmail: userEmail),
                  const SecurityWidget(),

                  const SizedBox(height: 20),

                  Text(
                    'Meldingen',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    'Privacy en Veiligheid',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Over deze app',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hulp en ondersteuning',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Versie-informatie',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Log uit',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40), // Extra space at bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
