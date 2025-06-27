import 'package:flutter/material.dart';

class NewMatchWidget extends StatelessWidget {
  const NewMatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Match'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, color: Colors.red, size: 100),
            SizedBox(height: 20),
            Text(
              'It\'s a Match!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'You and Alex have liked each other.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Add your action here
              },
              child: Text('Send a Message'),
            ),
            TextButton(
              onPressed: () {
                // Add your action here
              },
              child: Text('Keep Swiping'),
            ),
          ],
        ),
      ),
    );
  }
}
