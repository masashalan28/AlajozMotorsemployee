//import 'package:AlajozMotorsemployee/features/home/presentation/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/user_cubit.dart';
import '../forgot_password_screen.dart';

import '../../../../../core/widgets/CustomButton.dart';
import 'auth_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 void _submitForm() {
  if (_formKey.currentState!.validate()) {
   
    final rawPhone = _phoneController.text.trim();

 
    final phone = '+963$rawPhone';
    final password = _passwordController.text.trim();

    context.read<UserCubit>().login(
          phone: phone,
          password: password,
        );
  }
}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PhoneTextField(controller: _phoneController),
          const SizedBox(height: 15),
          PasswordTextField(controller: _passwordController),
          const SizedBox(height: 20),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return CustomButton(
                text: state is UserLoading ? 'Logging in...' : 'Log in',
                onPressed: state is UserLoading ? () {} : _submitForm,
              );
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPasswordScreen(),
                ),
              );
            },
            child: const Text(
              'Need help? Reset Password',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
