import 'package:flutter/material.dart';

class MatchMeSettingScreen extends StatelessWidget {
  const MatchMeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        toolbarHeight: 45,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        scrolledUnderElevation: 0,
      ),
      body: const Center(
        child: Text('MatchMe Settings Screen', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
