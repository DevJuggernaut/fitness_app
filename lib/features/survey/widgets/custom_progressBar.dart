import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // Значение прогресса от 0.0 до 1.0

  const CustomProgressBar({required this.progress, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      return Container(
        height: 8.0, // Высота прогресс-бара
        decoration: BoxDecoration(
          color: Color(0xFFC8C1C1), // Цвет фона прогресс-бара
          borderRadius: BorderRadius.circular(5), // Скругленные края
        ),
        child: Stack(
          children: [
            Container(
              width: maxWidth * progress,
              decoration: BoxDecoration(
                color: Color(0xFF999494), // Цвет заполнения прогресс-бара
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      );
    });
  }
}
