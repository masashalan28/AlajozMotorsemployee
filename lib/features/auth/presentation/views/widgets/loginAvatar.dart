import 'package:AlajozMotorsemployee/core/utils/assets.dart';
import 'package:flutter/material.dart';


class LoginAvatar extends StatelessWidget {
  const LoginAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 80,
      backgroundImage: AssetImage(AssetsData.login),
    );
  }
}