import 'package:flutter/material.dart';

class NewLikeWidget extends StatelessWidget {
  const NewLikeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Like')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, color: Colors.red, size: 100),
            const SizedBox(height: 20),
            const Text(
              'You have a new like!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your navigation or action here
              },
              child: const Text('View Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
