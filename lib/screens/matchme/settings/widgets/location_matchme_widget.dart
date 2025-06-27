import 'package:flutter/material.dart';

class LocationMatchMeWidget extends StatelessWidget {
  const LocationMatchMeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enable Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Allow access to location'),
              value: true, // Replace with your state management logic
              onChanged: (bool value) {
                // Handle toggle logic here
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Location Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Set location accuracy'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to location accuracy settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
