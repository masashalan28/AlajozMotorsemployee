import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/user_cubit.dart';
import '../../../../core/services/storage_service.dart';

class ProfileTestScreen extends StatefulWidget {
  const ProfileTestScreen({super.key});

  @override
  State<ProfileTestScreen> createState() => _ProfileTestScreenState();
}

class _ProfileTestScreenState extends State<ProfileTestScreen> {
  String? _token;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await StorageService.getToken();
    setState(() {
      _token = token;
    });
  }

  Future<void> _testProfileAPI() async {
    if (_token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد token محفوظ. يرجى تسجيل الدخول أولاً'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<UserCubit>().getProfile(token: _token!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطأ في استدعاء API: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختبار API البروفايل'),
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
      ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم تحميل البروفايل بنجاح: ${state.user.name}'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('خطأ: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'معلومات API',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Base URL: https://ajouzmotors.online/api'),
                      Text('Endpoint: /v1/user/profile'),
                      Text('Method: GET'),
                      Text('Headers: Authorization: Bearer {token}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'معلومات Token',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Token: ${_token ?? "غير محفوظ"}',
                        style: TextStyle(
                          color: _token != null ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _loadToken,
                        child: const Text('تحديث Token'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _testProfileAPI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('جاري التحميل...'),
                        ],
                      )
                    : const Text(
                        'اختبار API البروفايل',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'نتيجة API',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('الاسم: ${state.user.name}'),
                            Text('الهاتف: ${state.user.phone}'),
                            Text('البريد الإلكتروني: ${state.user.email}'),
                            Text('ID: ${state.user.id}'),
                            if (state.user.createdAt != null)
                              Text('تاريخ الإنشاء: ${state.user.createdAt}'),
                            if (state.user.updatedAt != null)
                              Text('تاريخ التحديث: ${state.user.updatedAt}'),
                          ],
                        ),
                      ),
                    );
                  } else if (state is UserError) {
                    return Card(
                      color: Colors.red.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'خطأ في API',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('الرسالة: ${state.message}'),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
