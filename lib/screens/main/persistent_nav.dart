import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matchme_lover/chat/chat_screen.dart';
import 'package:matchme_lover/likes/likes_screen.dart';
import 'package:matchme_lover/profile/profile_screen.dart';
import 'package:matchme_lover/quiz/quiz_screen.dart';
import 'package:matchme_lover/screens/matchme/matchme_screen.dart';

class PersistentTabScreen extends StatefulWidget {
  const PersistentTabScreen({super.key});

  @override
  State<PersistentTabScreen> createState() => _PersistentTabScreenState();
}

class _PersistentTabScreenState extends State<PersistentTabScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MatchMeScreen(),
    const ChatScreen(),
    const QuizScreen(),
    const LikesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              0,
              'MATCHME',
              SizedBox(
                width: 50,
                height: 32,
                child: Center(
                  child: Image.asset(
                    _currentIndex == 0
                        ? 'assets/logo.png'
                        : 'assets/logo_grey.png',
                    width: 50,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            _buildNavItem(
              1,
              'CHAT',
              Image.asset(
                _currentIndex == 1
                    ? 'assets/Chat_red.png'
                    : 'assets/chat_grey.png',
                width: 32,
                height: 32,
              ),
            ),
            _buildNavItem(
              2,
              'QUIZ',
              Icon(
                Icons.quiz,
                size: 28,
                color: _currentIndex == 2
                    ? const Color.fromARGB(255, 236, 28, 36)
                    : Colors.grey,
              ),
            ),
            _buildNavItem(
              3,
              'LIKES',
              Image.asset(
                _currentIndex == 3
                    ? 'assets/likes_red.png'
                    : 'assets/likes_grey.png',
                width: 40,
                height: 28,
              ),
            ),
            _buildNavItem(
              4,
              'PROFILE',
              Icon(
                CupertinoIcons.person_fill,
                size: 28,
                color: _currentIndex == 4
                    ? const Color.fromARGB(255, 236, 28, 36)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, Widget icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 1, bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: _currentIndex == index
                    ? const Color.fromARGB(255, 236, 28, 36)
                    : Colors.grey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
