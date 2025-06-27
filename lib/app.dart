import 'package:flutter/material.dart';
import 'package:matchme_lover/chat/chat%20settings/chat_settings_screen.dart';

import 'package:matchme_lover/profile/profile%20edit/profile_edit_screen.dart';
import 'package:matchme_lover/profile/profile%20settings/profile_settings_screen.dart';
import 'package:matchme_lover/profile/profile%20view/profile_view_screen.dart';
import 'package:matchme_lover/screens/main/splash_screen.dart';
import 'package:matchme_lover/screens/main/welcome_screen.dart';
import 'package:matchme_lover/screens/auth/signin_screen.dart';
import 'package:matchme_lover/screens/auth/signup_screen.dart';
import 'package:matchme_lover/screens/matchme/settings/matchme_setting.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatchMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 236, 28, 36),
          surface: Colors.white,
          secondary: Colors.black,
          outlineVariant: Color.fromARGB(255, 26, 26, 26),
          onSurfaceVariant: Color.fromARGB(255, 117, 117, 117),
          tertiary: Color.fromARGB(255, 12, 12, 12),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/matchme/settings': (context) => const MatchMeSettingScreen(),
        '/matchme/profile_edit': (context) => const ProfileEditScreen(),
        '/matchme/profile_view': (context) => const ProfileViewScreen(),
        '/matchme/profile_settings': (context) => const ProfileSettingsScreen(),

        '/matchme/chat_settings': (context) => const ChatSettingsScreen(),
      },
    );
  }
}
