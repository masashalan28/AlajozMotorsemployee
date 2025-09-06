import 'package:flutter/material.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController? controller;

  const PhoneTextField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: ' Enter phone number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
          ),
          child: const Text(
            '+963',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your phone number';
        }
        if (!RegExp(r'^[0-9]{9}$').hasMatch(value)) {
          return 'Enter a valid phone number (9 digits)';
        }
        return null;
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController? controller;

  PasswordTextField({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(),
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
