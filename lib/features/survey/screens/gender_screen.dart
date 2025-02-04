import 'package:fitness_app/core/models/user_data.dart';
import 'package:fitness_app/features/survey/widgets/ContinueButton.dart';
import 'package:fitness_app/features/survey/widgets/SurveyAppBar.dart';
import 'package:fitness_app/features/widgets/skip_button.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDED),
      appBar: SurveyAppBar(
        progress: 0.34,
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
              'Tell Us About Yourself',
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
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGender = 'Male';
                    });
                  },
                  child: Container(
                    height: 213,
                    width: 151,
                    decoration: BoxDecoration(
                      color: _selectedGender == 'Male'
                          ? const Color(0xFF999494)
                          : const Color(0xFFC8C1C1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 59,
                          width: 59,
                          decoration: BoxDecoration(
                            color: _selectedGender == 'Male'
                                ? const Color(0xFFF1EDED)
                                : const Color(0xFF999494),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(height: 35),
                        const Text(
                          'Male',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 26),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGender = 'Female';
                    });
                  },
                  child: Container(
                    height: 213,
                    width: 151,
                    decoration: BoxDecoration(
                      color: _selectedGender == 'Female'
                          ? const Color(0xFF999494)
                          : const Color(0xFFC8C1C1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 59,
                          width: 59,
                          decoration: BoxDecoration(
                            color: _selectedGender == 'Female'
                                ? const Color(0xFFF1EDED)
                                : const Color(0xFF999494),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(height: 35),
                        const Text(
                          'Female',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'To provide you with better experience, we need to know your gender.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w900,
                color: Color(0xFF5B5959),
              ),
            ),
            const SizedBox(height: 152),
            ContinueButton(
              onPressed: _selectedGender != null
                  ? () => Navigator.pushNamed(context, '/birthdate-screen')
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
