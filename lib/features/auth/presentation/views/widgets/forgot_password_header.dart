import 'package:flutter/material.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.lock_reset, size: 80, color: Colors.yellow),
        SizedBox(height: 30),
        Text(
          'Forgot password',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Enter your phone number and we will send you a verification code.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
