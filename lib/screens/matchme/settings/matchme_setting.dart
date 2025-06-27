import 'package:flutter/material.dart';

class MatchMeSettingScreen extends StatelessWidget {
  const MatchMeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Center(
        child: Text('MatchMe Settings Screen', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
