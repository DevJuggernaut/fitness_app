import 'package:fitness_app/features/survey/widgets/ContinueButton.dart';
import 'package:fitness_app/features/survey/widgets/HeightPicker.dart';
import 'package:fitness_app/features/survey/widgets/SurveyAppBar.dart';
import 'package:fitness_app/features/widgets/skip_button.dart';
import 'package:flutter/material.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  int _selectedHeight = 185;
  HeightUnit _selectedUnit = HeightUnit.cm; // Состояние выбранной единицы

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDED),
      appBar: SurveyAppBar(
        progress: 0.68,
        left: Padding(
          padding: const EdgeInsets.only(left: 23),
          child: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
        ),
        right: SkipButton(
          onPressed: () => Navigator.pushNamed(context, '/home'),
          rightPadding: 23,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 63),
            const Text(
              'What’s Your Height?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Переключатель единиц измерения (cm / ft/in)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedUnit = HeightUnit.cm;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 41,
                    width: 86,
                    decoration: BoxDecoration(
                      color: _selectedUnit == HeightUnit.cm
                          ? Color(0xFF999494)
                          : const Color(0xFFC7C1C1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'cm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedUnit = HeightUnit.ftin;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 41,
                    width: 86,
                    decoration: BoxDecoration(
                      color: _selectedUnit == HeightUnit.ftin
                          ? Color(0xFF999494)
                          : const Color(0xFFC7C1C1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'ft/in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Передаём выбранную единицу в HeightPicker
            HeightPicker(
              initialHeight: 170,
              heightUnit: _selectedUnit,
              onHeightChanged: (height) {
                setState(() {
                  _selectedHeight = height;
                });
              },
            ),
            const SizedBox(height: 215),
            ContinueButton(
              onPressed: () => Navigator.pushNamed(context, '/weight-screen'),
            ),
          ],
        ),
      ),
    );
  }
}
