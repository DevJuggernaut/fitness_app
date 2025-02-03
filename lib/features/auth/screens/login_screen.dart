import 'package:flutter/material.dart';
import 'package:fitness_app/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/auth/bloc/auth_bloc.dart';
import 'package:fitness_app/features/auth/bloc/auth_state.dart';
import 'package:fitness_app/features/auth/bloc/auth_event.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    logger.d('Email: $email, Password: $password');

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email format')),
      );
      return;
    }

    context.read<AuthBloc>().add(
          LoginRequested(email: email, password: password),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EDED),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1EDED),
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AuthSuccess) {
                Future.microtask(() {
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                });
                return Container();
              }
              if (state is AuthFailure) {
                //logger.d('Error: ${state.error}');
                return Column(
                  children: [
                    Text(state.error, style: TextStyle(color: Colors.red)),
                    ElevatedButton(
                      onPressed: () => _login(context),
                      child: Text('Login'),
                    ),
                  ],
                );
              }
              return ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Login'),
              );
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Don\'t have an account? Sign up')),
        ],
      ),
    );
  }
}
