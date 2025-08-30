import 'package:AlajozMotorsemployee/features/home/presentation/views/home.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/CustomButton.dart';
import 'auth_text_field.dart';

class LoginForm extends StatefulWidget {
  final bool rememberMe;
  final ValueChanged<bool> onRememberChanged;

  const LoginForm({
    super.key,
    required this.rememberMe,
    required this.onRememberChanged,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeHomeScreen(
            employeeName: 'Ahmed',
            loginTime: DateTime.now(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          phonTextField(),
          const SizedBox(height: 15),
          PasswordTextField(),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Log in',
            onPressed: _submitForm,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: widget.rememberMe,
                    onChanged: (value) {
                      widget.onRememberChanged(value ?? false);
                    },
                  ),
                  const Text('Remember me'),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Need help? Reset'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: const Text(
              'New here? Create an account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
