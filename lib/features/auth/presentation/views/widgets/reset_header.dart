import 'package:flutter/material.dart';

class ResetHeader extends StatelessWidget {
  final String phone;

  const ResetHeader({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.verified_user,
          size: 80,
          color: Colors.yellow,
        ),
        const SizedBox(height: 30),
        const Text(
          'Reset password',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Enter the verification code sent to $phone',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
