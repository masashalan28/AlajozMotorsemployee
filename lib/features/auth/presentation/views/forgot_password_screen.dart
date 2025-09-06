import 'package:AlajozMotorsemployee/core/utils/error_messages.dart';
import 'package:AlajozMotorsemployee/core/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/user_cubit.dart';
import 'verify_reset_code_screen.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/forgot_password_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendResetCode() {
    if (_formKey.currentState!.validate()) {
      final rawPhone = _phoneController.text.trim();
      final phone = '+963$rawPhone';

      context.read<UserCubit>().forgetPassword(phone: phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password'),
        foregroundColor: Colors.black,
      ),
      
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is PasswordResetCodeSent) {
            setState(() => _isLoading = false);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'تم إرسال رمز التحقق إلى +963${_phoneController.text.trim()}'),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyResetCodeScreen(
                  phone: '+963${_phoneController.text.trim()}',
                ),
              ),
            );
          } else if (state is UserError) {
            setState(() => _isLoading = false);
            String errorMessage = ErrorMessages.getUserFriendly(state.message);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          } else if (state is UserLoading) {
            setState(() => _isLoading = true);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ForgotPasswordHeader(),
                PhoneTextField(controller: _phoneController),
                const SizedBox(height: 30),
                CustomButton(
                  text: _isLoading ? 'Loading...' : 'Send verification code',
                  onPressed: _isLoading ? () {} : _sendResetCode,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Back to login',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
