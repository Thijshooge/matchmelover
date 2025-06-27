import 'package:flutter/material.dart';

class MatchMeSettingScreen extends StatelessWidget {
  const MatchMeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
        foregroundColor: Color.fromARGB(255, 236, 28, 36),
      ),
      body: const Center(
        child: Text('MatchMe Settings Screen', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
