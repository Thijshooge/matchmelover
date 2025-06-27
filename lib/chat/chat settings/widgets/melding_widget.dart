import 'package:flutter/material.dart';

class MeldingWidget extends StatelessWidget {
  const MeldingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Melding Widget')),
      body: Center(
        child: Text(
          'Welkom bij de Melding Widget!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MeldingWidget()));
}
