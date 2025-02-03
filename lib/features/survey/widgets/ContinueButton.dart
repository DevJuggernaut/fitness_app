import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const ContinueButton({
    Key? key,
    required this.onPressed,
    this.text = 'Continue',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        foregroundColor: const Color(0xFF000000),
        backgroundColor: const Color(0xFFC8C1C1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }
}
