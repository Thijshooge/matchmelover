import 'package:flutter/material.dart';

class GenderLoveWidget extends StatelessWidget {
  const GenderLoveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gender Love Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your preferences:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Gender:'),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
                DropdownMenuItem(value: 'other', child: Text('Other')),
              ],
              onChanged: (value) {
                // Handle gender selection
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text('Looking for:'),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
                DropdownMenuItem(value: 'any', child: Text('Any')),
              ],
              onChanged: (value) {
                // Handle preference selection
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Save preferences
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
