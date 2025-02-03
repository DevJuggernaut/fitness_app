import 'package:fitness_app/core/models/user_data.dart';
import 'package:fitness_app/features/auth/screens/register_screen.dart';
import 'package:fitness_app/features/auth/screens/welcome_screen.dart';
import 'package:fitness_app/features/home/screens/home_screen.dart';
import 'package:fitness_app/features/survey/screens/birthdate_screen.dart';
import 'package:fitness_app/features/survey/screens/gender_screen.dart';
import 'package:fitness_app/features/survey/screens/goal_screen.dart';
import 'package:fitness_app/features/survey/screens/height_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/auth/bloc/auth_bloc.dart';
import 'package:fitness_app/features/auth/repository/auth_repository.dart';
import 'package:fitness_app/features/auth/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // Для iOS:
        statusBarBrightness: Brightness.light, // Тёмные значки (время, батарея)
        statusBarIconBrightness:
            Brightness.light, // Для Android (не влияет на iOS)
        systemNavigationBarColor:
            Colors.transparent, // Прозрачный фон для Home Indicator
        systemNavigationBarContrastEnforced:
            false, // Отключение контраста (iOS)
      ),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: AuthRepository(
              // apiService: ApiService(),
              ),
        ),
        child: MaterialApp(
          title: 'Fitness App',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                // Змінюємо фон при натисканні
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Color(0xFF999595);
                    }
                    return null; // Не змінювати інші стани
                  },
                ),
              ),
            ),
          ),
          initialRoute: '/welcome',
          routes: {
            '/welcome': (context) => const WelcomeScreen(),
            '/home': (context) => const HomeScreen(),
            '/login': (context) => LoginScreen(),
            '/register': (context) => RegisterScreen(),
            '/goal-screen': (context) => GoalScreen(
                  userData:
                      ModalRoute.of(context)!.settings.arguments as UserData,
                ),
            '/gender-screen': (context) => const GenderScreen(),
            '/birthdate-screen': (context) => const BirthdateScreen(),
            '/height-screen': (context) => const HeightScreen(),
          },
        ),
      ),
    );
  }
}
