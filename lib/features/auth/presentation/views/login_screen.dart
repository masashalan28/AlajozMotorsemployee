import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/loginAvatar.dart';
import 'widgets/loginForm.dart';
import '../manager/user_cubit.dart';
import '../../../home/presentation/views/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _getUserFriendlyErrorMessage(String errorMessage) {
 
    if (errorMessage.contains('401') || errorMessage.contains('Unauthorized')) {
      return 'رقم الهاتف أو كلمة المرور غير صحيحة';
    } else if (errorMessage.contains('404') ||
        errorMessage.contains('Not Found')) {
      return 'المستخدم غير موجود';
    } else if (errorMessage.contains('500') ||
        errorMessage.contains('Server Error')) {
      return 'خطأ في الخادم، حاول مرة أخرى';
    } else if (errorMessage.contains('timeout') ||
        errorMessage.contains('Timeout')) {
      return 'انتهت مهلة الاتصال، تحقق من الإنترنت';
    } else if (errorMessage.contains('SocketException') ||
        errorMessage.contains('Network')) {
      return 'لا يوجد اتصال بالإنترنت';
    } else if (errorMessage.contains('Login failed') ||
        errorMessage.contains('Invalid credentials')) {
      return 'رقم الهاتف أو كلمة المرور غير صحيحة';
    } else {
      return 'حدث خطأ، حاول مرة أخرى';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoggedIn) {
           
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeHomeScreen(
                    employeeName: state.user.name,
                    loginTime: DateTime.now(),
                  ),
                ),
              );
            } else if (state is UserError) {
              
              String errorMessage = _getUserFriendlyErrorMessage(state.message);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          child: const Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginAvatar(),
                  SizedBox(height: 30),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Log in to access the system',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 30),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
