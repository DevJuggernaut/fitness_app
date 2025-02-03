import 'package:fitness_app/features/widgets/skip_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDED),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1EDED),
        elevation: 0,
        actions: [
          SkipButton(
            onPressed: () => Navigator.pushNamed(context, '/home'),
            rightPadding: 23,
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 128.0),
                  const Text(
                    'Welcome to TrueForm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                        color: Color(0xFF000000)),
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(
                    child: Text(
                      'Step Up Your Game - Anytime, Anywhere.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF5B5959),
                      ),
                    ),
                  ),
                  const SizedBox(height: 268.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      foregroundColor: Color(0xFF000000),
                      backgroundColor: Color(0xFFC8C1C1),
                    ),
                    child: const Text(
                      'Sigh Up',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF000000)),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      foregroundColor: Color(0xFF000000),
                      backgroundColor: Color(0xFFC8C1C1),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF000000)),
                    ),
                  ),
                ],
              ))),
    );
  }
}
