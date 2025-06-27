import 'dart:ui'; // nodig voor ImageFilter.blur
import 'package:flutter/material.dart';

class AchtergrondStart extends StatelessWidget {
  const AchtergrondStart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Zwarte achtergrondkleur
    const backgroundColor = Colors.black;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          // 1. Zwarte achtergrond
          Container(color: backgroundColor),

          // 2. Vage cirkels met kleuren en blur
          Align(
            alignment: const AlignmentDirectional(20, -1.0),
            child: Container(
              height: screenWidth,
              width: screenWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(1.8, -0.8),
            child: Container(
              height: screenWidth / 1.3,
              width: screenWidth / 1.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 236, 28, 36),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 160.0),
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
