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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDED),
      appBar: SurveyAppBar(
        progress: 0.8,
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
        padding: EdgeInsets.symmetric(horizontal: 31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 63),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 41,
                  width: 86,
                  decoration: BoxDecoration(
                    color: Color(0xFFC7C1C1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'cm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  alignment: Alignment.center,
                  height: 41,
                  width: 86,
                  decoration: BoxDecoration(
                    color: Color(0xFFC7C1C1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'ft/in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Виджет выбора роста
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // ListWheelScrollView для прокрутки значений
                  ListWheelScrollView.useDelegate(
                    itemExtent: 50, // Высота одного элемента
                    diameterRatio: 1.5, // Радиус колеса
                    perspective: 0.005, // Эффект перспективы
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedHeight = 170 + index; // Значение от 170 до 200
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final height = 170 + index; // Диапазон значений
                        return Center(
                          child: Text(
                            height.toString(),
                            style: TextStyle(
                              fontSize: height == _selectedHeight ? 24 : 16,
                              fontWeight: height == _selectedHeight
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: height == _selectedHeight
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        );
                      },
                      childCount: 31, // Количество элементов (170-200)
                    ),
                  ),
                  // Треугольный указатель для выбранного значения
                  const Positioned(
                    bottom: 150,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
