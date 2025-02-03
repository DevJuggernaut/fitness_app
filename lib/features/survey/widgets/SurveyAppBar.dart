import 'package:flutter/material.dart';
import 'package:fitness_app/features/survey/widgets/custom_progressBar.dart';

class SurveyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double progress;
  final Widget? left; // Для кнопки "Назад" или другого элемента слева
  final Widget? right; // Для кнопки "Skip" или другого элемента справа

  const SurveyAppBar({
    Key? key,
    required this.progress,
    this.left,
    this.right,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(56); // стандартная высота AppBar

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: preferredSize.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Центр – наш прогресс-бар
            SizedBox(
              width: 120,
              child: CustomProgressBar(progress: progress),
            ),
            // Если есть левый виджет (например, BackButton), размещаем его слева
            if (left != null)
              Positioned(
                left: 0,
                child: left!,
              ),
            // Если есть правый виджет (например, SkipButton), размещаем его справа
            if (right != null)
              Positioned(
                right: 0,
                child: right!,
              ),
          ],
        ),
      ),
    );
  }
}
