import 'package:fitness_app/features/survey/widgets/ContinueButton.dart';
import 'package:fitness_app/features/survey/widgets/WeightPicker.dart';
import 'package:fitness_app/features/survey/widgets/SurveyAppBar.dart';
import 'package:fitness_app/features/widgets/skip_button.dart';
import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  int _selectedWeight = 70; // Начальное значение веса
  WeightUnit _selectedUnit =
      WeightUnit.kg; // Состояние выбранной единицы измерения

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDED),
      appBar: SurveyAppBar(
        progress: 0.85,
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
              'What’s Your Current Weight?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Переключатель единиц измерения (kg / lbs)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedUnit = WeightUnit.kg;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 41,
                    width: 86,
                    decoration: BoxDecoration(
                      color: _selectedUnit == WeightUnit.kg
                          ? const Color(0xFF999494)
                          : const Color(0xFFC7C1C1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'kg',
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
                      _selectedUnit = WeightUnit.lbs;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 41,
                    width: 86,
                    decoration: BoxDecoration(
                      color: _selectedUnit == WeightUnit.lbs
                          ? const Color(0xFF999494)
                          : const Color(0xFFC7C1C1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'lbs',
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
            // Передаём выбранную единицу в WeightPicker
            WeightPicker(
              initialWeight: 70,
              weightUnit: _selectedUnit,
              onWeightChanged: (weight) {
                setState(() {
                  _selectedWeight = weight;
                });
              },
            ),
            const SizedBox(height: 215),
            ContinueButton(
              onPressed: () => Navigator.pushNamed(context, '/home'),
            ),
          ],
        ),
      ),
    );
  }
}
