import 'package:fitness_app/core/models/user_data.dart';
import 'package:fitness_app/features/survey/screens/gender_screen.dart';
import 'package:fitness_app/features/survey/widgets/ContinueButton.dart';
import 'package:fitness_app/features/survey/widgets/SurveyAppBar.dart';
import 'package:fitness_app/features/survey/widgets/custom_checkbox.dart';
import 'package:fitness_app/features/survey/widgets/custom_progressBar.dart';
import 'package:fitness_app/features/widgets/skip_button.dart';
import 'package:flutter/material.dart';

class GoalScreen extends StatefulWidget {
  final UserData userData;
  const GoalScreen({super.key, required this.userData});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String? _selectedGoal;

  final List<String> _goals = [
    'Weight loss',
    'Build Muscle',
    'Track my nutrition'
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Блокируем свайп назад
      child: Scaffold(
        backgroundColor: const Color(0xFFF1EDED),
        appBar: SurveyAppBar(
          progress: 0.2, // пример: 20% заполнения
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
                "What's Your Main Goal?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "You can change this later",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5B5959),
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 202),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _goals.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return _GoalCard(
                      title: _goals[index],
                      isSelected: _selectedGoal == _goals[index],
                      onTap: () =>
                          setState(() => _selectedGoal = _goals[index]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 215),
              ContinueButton(
                onPressed: _selectedGoal != null
                    ? () => Navigator.pushNamed(context, '/gender-screen')
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _GoalCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF999494) : Color(0xFFC8C1C1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.black,
            width: 1,
          ),
        ),
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            CustomCheckbox(
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }
}
