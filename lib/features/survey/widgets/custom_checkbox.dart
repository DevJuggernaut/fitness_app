import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isSelected;
  final Color fillColor;
  final Color borderColor;
  final double size;

  const CustomCheckbox({
    super.key,
    required this.isSelected,
    this.fillColor = const Color(0xFF999494),
    this.borderColor = const Color(0xFF999494),
    this.size = 22.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : fillColor,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              size: size * 0.9,
              color: borderColor,
            )
          : null,
    );
  }
}
