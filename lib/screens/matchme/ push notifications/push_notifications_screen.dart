import 'package:flutter/material.dart';

class PushNotificationsScreen extends StatelessWidget {
  const PushNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        scrolledUnderElevation: 0,
        title: const Text('Push Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text('No new notifications', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logic here
              },
              child: const Text('Check for Notifications'),
            ),
          ],
        ),
      ),
    );
  }
}
