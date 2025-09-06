import 'package:AlajozMotorsemployee/core/utils/error_messages.dart';
import 'package:AlajozMotorsemployee/core/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/user_cubit.dart';
import 'login_screen.dart';
import 'widgets/otp_text_field.dart';
import 'widgets/password_fields.dart';
import 'widgets/reset_header.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  final String phone;

  const VerifyResetCodeScreen({
    super.key,
    required this.phone,
  });

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool _isPasswordStrong(String password) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    return hasUppercase && hasLowercase;
  }

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _verifyAndReset() {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('كلمة المرور غير متطابقة'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      context.read<UserCubit>().resetPassword(
            phone: widget.phone,
            otp: _otpController.text.trim(),
            newPassword: _newPasswordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
        foregroundColor: Colors.black,
      ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else if (state is UserError) {
            setState(() {
              _isLoading = false;
            });
            String errorMessage =
                ErrorMessages.getUserFriendlyErrorMessage(state.message);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          } else if (state is UserLoading) {
            setState(() {
              _isLoading = true;
            });
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                ResetHeader(phone: widget.phone),
                const SizedBox(height: 40),
                OtpTextField(controller: _otpController),
                const SizedBox(height: 20),
                PasswordFields(
                  newPasswordController: _newPasswordController,
                  confirmPasswordController: _confirmPasswordController,
                  isPasswordVisible: _isPasswordVisible,
                  isConfirmPasswordVisible: _isConfirmPasswordVisible,
                  togglePasswordVisibility: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                  toggleConfirmPasswordVisibility: () {
                    setState(() =>
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                  },
                  isPasswordStrong: _isPasswordStrong,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: _isLoading ? 'Loading...' : 'Reset password',
                  onPressed: _isLoading ? () {} : _verifyAndReset,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    context
                        .read<UserCubit>()
                        .forgetPassword(phone: widget.phone);
                  },
                  child: const Text(
                    'Resend code',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
