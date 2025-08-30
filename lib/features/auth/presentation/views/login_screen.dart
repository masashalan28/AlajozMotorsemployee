import 'package:flutter/material.dart';
import 'widgets/loginAvatar.dart';
import 'widgets/loginForm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoginAvatar(),
                const SizedBox(height: 30),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text('Log in to manage your tasks', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 30),
                LoginForm(
                  rememberMe: rememberMe,
                  onRememberChanged: (value) {
                    setState(() {
                      rememberMe = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





































