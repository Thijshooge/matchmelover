import 'package:flutter/material.dart';

class CallWidget extends StatelessWidget {
  const CallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call Screen'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.call, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Calling...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to end the call
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('End Call'),
            ),
          ],
        ),
      ),
    );
  }
}
