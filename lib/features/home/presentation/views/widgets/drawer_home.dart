import 'package:AlajozMotorsemployee/core/utils/assets.dart';
import 'package:AlajozMotorsemployee/features/auth/presentation/views/login_screen.dart';
import 'package:AlajozMotorsemployee/features/home/presentation/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/presentation/manager/user_cubit.dart';

class HomeDrawer extends StatelessWidget {
  final String employeeName;

  const HomeDrawer({
    super.key,
    required this.employeeName,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.yellow,
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(AssetsData.profile),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    employeeName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.person_2_outlined,
            label: 'My Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EmployeeProfile()),
              );
            },
          ),
          _buildDrawerItem(
              icon: Icons.settings, label: 'Settings', onTap: () {}),
          const Divider(),
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserLoggedOut) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else if (state is UserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: _buildDrawerItem(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('تسجيل الخروج'),
                    content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('إلغاء'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          // Get saved token and logout
                          final token =
                              await context.read<UserCubit>().getSavedToken();
                          if (token != null) {
                            context.read<UserCubit>().logout(token: token);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('لم يتم العثور على token'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text('تسجيل الخروج'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
