import 'package:flutter/material.dart';

class OtpTextField extends StatelessWidget {
  final TextEditingController? controller;

  const OtpTextField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(),
      decoration: const InputDecoration(
        labelText: 'Verification code',
        prefixIcon: Icon(Icons.security),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال رمز التحقق';
        }
        if (value.length < 6) {
          return 'رمز التحقق يجب أن يكون 6 أرقام على الأقل';
        }
        return null;
      },
    );
  }
}
