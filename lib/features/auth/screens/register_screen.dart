import 'package:fitness_app/core/models/user_data.dart';
import 'package:fitness_app/features/auth/bloc/auth_bloc.dart';
import 'package:fitness_app/features/auth/bloc/auth_event.dart';
import 'package:fitness_app/features/auth/bloc/auth_state.dart';
import 'package:fitness_app/features/survey/screens/goal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // final result =
    //     await context.read<AuthBloc>().authRepository.register(email, password);

    context.read<AuthBloc>().add(
          RegisterRequested(email: email, password: password),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EDED),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1EDED),
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is AuthSuccess) {
                  Future.microtask(() {
                    Navigator.pushReplacementNamed(
                      context,
                      '/goal-screen',
                      arguments: UserData(), // Передаем пустой объект UserData
                    );
                  });
                  return Container();
                }
                if (state is AuthFailure) {
                  // Показуємо помилку
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  });
                  // Повертаємо кнопку для повторної спроби
                  return ElevatedButton(
                    onPressed: () => _register(context),
                    child: Text('Register'),
                  );
                }
                // Якщо стан початковий або інший, показуємо кнопку
                return ElevatedButton(
                  onPressed: () => _register(context),
                  child: Text('Register'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
