import 'package:fitness_app/features/survey/widgets/ContinueButton.dart';
import 'package:fitness_app/features/survey/widgets/SurveyAppBar.dart';
import 'package:fitness_app/features/widgets/skip_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BirthdateScreen extends StatefulWidget {
  const BirthdateScreen({super.key});

  @override
  State<BirthdateScreen> createState() => _BirthdateScreenState();
}

class _BirthdateScreenState extends State<BirthdateScreen> {
  DateTime _selectedDate = DateTime(2000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDED),
      appBar: SurveyAppBar(
        progress: 0.6,
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
              'When’s Your Birthday?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 96),
            SizedBox(
              height: 110,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    // Стиль для неактивных элементов
                    pickerTextStyle: TextStyle(
                      color: Colors.black.withValues(
                          red: 0, green: 0, blue: 0, alpha: (0.5 * 255)),
                      fontSize: 18,
                    ),
                    // Стиль для выбранного элемента
                    dateTimePickerTextStyle: TextStyle(
                      fontSize: 18, // Размер шрифта для всех элементов
                      fontWeight: FontWeight.w900, // Жирность
                      fontFamily: 'Inter', // Шрифт
                      color: Colors.black, // Цвет текста
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
                  dateOrder: DatePickerDateOrder.dmy,
                  itemExtent: 30,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 277),
            ContinueButton(
              onPressed: _selectedDate != null
                  ? () => Navigator.pushNamed(context, '/height-screen')
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
