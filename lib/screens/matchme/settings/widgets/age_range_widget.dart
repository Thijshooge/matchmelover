import 'package:flutter/material.dart';

class AgeRangeWidget extends StatefulWidget {
  const AgeRangeWidget({super.key});

  @override
  _AgeRangeWidgetState createState() => _AgeRangeWidgetState();
}

class _AgeRangeWidgetState extends State<AgeRangeWidget> {
  RangeValues _currentRange = RangeValues(18, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Age Range')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Age Range',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            RangeSlider(
              values: _currentRange,
              min: 18,
              max: 100,
              divisions: 82,
              labels: RangeLabels(
                _currentRange.start.round().toString(),
                _currentRange.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRange = values;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Selected Range: ${_currentRange.start.round()} - ${_currentRange.end.round()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
