import 'package:flutter/material.dart';
import 'dart:async';

import 'package:matchme_lover/widgets/achtergrond_start.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const AchtergrondStart(), // Achtergrond zonder content
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo.png', height: 250),
              const SizedBox(height: 10),
              const Text(
                'MatchMe',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 236, 28, 36),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
