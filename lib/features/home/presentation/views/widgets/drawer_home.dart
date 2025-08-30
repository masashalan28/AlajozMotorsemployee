import 'package:AlajozMotorsemployee/features/auth/presentation/views/login_screen.dart';
import 'package:AlajozMotorsemployee/features/home/presentation/views/profile.dart';
import 'package:flutter/material.dart';


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
                    backgroundImage:
                        AssetImage('assets/images/undraw_female-avatar_7t6k(3).png'),
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
                MaterialPageRoute(builder: (context) => const EmployeeProfile()),
              );
            },
          ),
          _buildDrawerItem(icon: Icons.settings, label: 'Settings', onTap: () {}),
          _buildDrawerItem(icon: Icons.notifications, label: 'Notifications', onTap: () {}),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
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
