import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/user_cubit.dart';

import 'login_screen.dart';

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

  String _getUserFriendlyErrorMessage(String errorMessage) {
    if (errorMessage.contains('401') || errorMessage.contains('Unauthorized')) {
      return 'رمز التحقق غير صحيح';
    } else if (errorMessage.contains('404') ||
        errorMessage.contains('Not Found')) {
      return 'الرمز منتهي الصلاحية، اطلب رمز جديد';
    } else if (errorMessage.contains('500') ||
        errorMessage.contains('Server Error')) {
      return 'خطأ في الخادم، حاول مرة أخرى';
    } else if (errorMessage.contains('timeout') ||
        errorMessage.contains('Timeout')) {
      return 'انتهت مهلة الاتصال، تحقق من الإنترنت';
    } else if (errorMessage.contains('SocketException') ||
        errorMessage.contains('Network')) {
      return 'لا يوجد اتصال بالإنترنت';
    } else if (errorMessage.contains('Invalid OTP') ||
        errorMessage.contains('Wrong OTP')) {
      return 'رمز التحقق غير صحيح';
    } else {
      return 'حدث خطأ، حاول مرة أخرى';
    }
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
        title: const Text('إعادة تعيين كلمة المرور'),
        //  backgroundColor: const Color(0xFFFFC107),
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
            String errorMessage = _getUserFriendlyErrorMessage(state.message);
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

                const Icon(
                  Icons.verified_user,
                  size: 80,
                  //color: Color(0xFFFFC107),
                  color: Colors.yellow,
                ),
                const SizedBox(height: 30),

                const Text(
                  'إعادة تعيين كلمة المرور',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    // color: Color(0xFFFFC107),
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'أدخل رمز التحقق المرسل إلى ${widget.phone}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),

                TextFormField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    labelText: 'رمز التحقق',
                    prefixIcon: Icon(Icons.security),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال رمز التحقق';
                    }
                    if (value.length < 4) {
                      return 'رمز التحقق يجب أن يكون 4 أرقام على الأقل';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _newPasswordController,
                  onChanged: (value) {
                    setState(() {}); 
                  },
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور الجديدة',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال كلمة المرور الجديدة';
                    }
                    if (value.length < 6) {
                      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                    }
                    if (!_isPasswordStrong(value)) {
                      return 'كلمة المرور يجب أن تحتوي على حرف كبير وحرف صغير على الأقل';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                
                if (_newPasswordController.text.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _isPasswordStrong(_newPasswordController.text)
                          ? Colors.green.shade50
                          : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _isPasswordStrong(_newPasswordController.text)
                            ? Colors.green
                            : Colors.orange,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isPasswordStrong(_newPasswordController.text)
                              ? Icons.check_circle
                              : Icons.warning,
                          color: _isPasswordStrong(_newPasswordController.text)
                              ? Colors.green
                              : Colors.orange,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _isPasswordStrong(_newPasswordController.text)
                                ? 'كلمة المرور قوية'
                                : 'كلمة المرور يجب أن تحتوي على حرف كبير وحرف صغير على الأقل',
                            style: TextStyle(
                              color:
                                  _isPasswordStrong(_newPasswordController.text)
                                      ? Colors.green.shade700
                                      : Colors.orange.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'تأكيد كلمة المرور',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isConfirmPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء تأكيد كلمة المرور';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                
                ElevatedButton(
                  onPressed: _isLoading ? null : _verifyAndReset,
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: const Color(0xFFFFC107),
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'إعادة تعيين كلمة المرور',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    context
                        .read<UserCubit>()
                        .forgetPassword(phone: widget.phone);
                  },
                  child: const Text(
                    'إعادة إرسال الرمز',
                    style: TextStyle(
                      //color: Color(0xFFFFC107),
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
