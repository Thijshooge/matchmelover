import 'package:flutter/material.dart';

class QuizSettingsScreen extends StatelessWidget {
  const QuizSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        scrolledUnderElevation: 0,
        title: const Text('Quiz Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable Timer'),
              value: true,
              onChanged: (bool value) {
                // Handle toggle logic here
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Difficulty',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'easy', child: Text('Easy')),
                DropdownMenuItem(value: 'medium', child: Text('Medium')),
                DropdownMenuItem(value: 'hard', child: Text('Hard')),
              ],
              onChanged: (String? value) {
                // Handle dropdown selection
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save settings logic
              },
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
