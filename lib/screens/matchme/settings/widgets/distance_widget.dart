import 'package:flutter/material.dart';

class DistanceWidget extends StatelessWidget {
  const DistanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Distance Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Maximum Distance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Slider(
              value: 50,
              min: 0,
              max: 100,
              divisions: 10,
              label: '50 km',
              onChanged: (value) {
                // Handle slider value change
              },
            ),
            SizedBox(height: 16),
            Text('Selected Distance: 50 km', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
