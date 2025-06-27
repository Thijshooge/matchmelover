import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:matchme_lover/screens/auth/signin_screen.dart';
import 'package:matchme_lover/screens/auth/signup_screen.dart';
import 'package:matchme_lover/widgets/achtergrond_start.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  final TapGestureRecognizer _privacyTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _termsTapRecognizer = TapGestureRecognizer();
  final Logger _logger = Logger('WelcomeScreen');

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    _privacyTapRecognizer.onTap = () {
      // TODO: Vervang door daadwerkelijke actie, bv. URL openen
      _logger.info('Privacy Policy tapped');
    };

    _termsTapRecognizer.onTap = () {
      // TODO: Vervang door daadwerkelijke actie, bv. URL openen
      _logger.info('Terms of Use tapped');
    };
  }

  @override
  void dispose() {
    tabController.dispose();
    _privacyTapRecognizer.dispose();
    _termsTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AchtergrondStart(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(child: Image.asset('assets/logo.png', height: 180)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TabBar(
                    controller: tabController,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Sign In', style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Sign Up', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [SignInScreen(), SignUpScreen()],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      children: [
                        const TextSpan(
                          text: 'By continuing, you agree to our ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 236, 28, 36),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: _privacyTapRecognizer,
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Terms of Use',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 236, 28, 36),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: _termsTapRecognizer,
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
