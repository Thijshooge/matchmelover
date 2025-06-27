import 'package:flutter/material.dart';

class MatchMeScreen extends StatelessWidget {
  const MatchMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
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
              'MatchMe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          // 3 iconen rechts - dichter bij elkaar
          IconButton(
            onPressed: () {
              // TODO: Implementeer notifications
            },
            padding: EdgeInsets.symmetric(horizontal: 4),
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.notifications_outlined,
              color: Color.fromARGB(255, 236, 28, 36),
              size: 24,
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/matchme/settings');
            },
            padding: EdgeInsets.symmetric(horizontal: 4),
            constraints: BoxConstraints(),
            icon: Icon(Icons.settings_outlined, size: 24),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to MatchMe!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
