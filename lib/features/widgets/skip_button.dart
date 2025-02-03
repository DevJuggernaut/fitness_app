import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double rightPadding;
  const SkipButton({required this.onPressed, this.rightPadding = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w900,
            color: Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}
