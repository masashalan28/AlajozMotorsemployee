import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/user_cubit.dart';
import 'verify_reset_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  String _getUserFriendlyErrorMessage(String errorMessage) {
    if (errorMessage.contains('404') || errorMessage.contains('Not Found')) {
      return 'رقم الهاتف غير مسجل في النظام';
    } else if (errorMessage.contains('500') ||
        errorMessage.contains('Server Error')) {
      return 'خطأ في الخادم، حاول مرة أخرى';
    } else if (errorMessage.contains('timeout') ||
        errorMessage.contains('Timeout')) {
      return 'انتهت مهلة الاتصال، تحقق من الإنترنت';
    } else if (errorMessage.contains('SocketException') ||
        errorMessage.contains('Network')) {
      return 'لا يوجد اتصال بالإنترنت';
    } else {
      return 'حدث خطأ، حاول مرة أخرى';
    }
  }

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
        title: const Text('نسيان كلمة المرور'),
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
            String errorMessage = _getUserFriendlyErrorMessage(state.message);
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
                const Icon(Icons.lock_reset, size: 80, color: Colors.yellow),
                const SizedBox(height: 30),
                const Text(
                  'نسيان كلمة المرور',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 10),
                const Text(
                  'أدخل رقم هاتفك وسنرسل لك رمز التحقق',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                // Phone Field
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'رقم الهاتف',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border(
                          right:
                              BorderSide(color: Colors.grey.shade400, width: 1),
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
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال رقم الهاتف';
                    }
                    if (!RegExp(r'^[0-9]{9}$').hasMatch(value)) {
                      return 'أدخل رقم صحيح مؤلف من 9 أرقام';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : _sendResetCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'إرسال رمز التحقق',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'العودة لتسجيل الدخول',
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
