import 'package:AlajozMotorsemployee/core/utils/assets.dart';
import 'package:flutter/material.dart';


class AppbarProfile extends StatelessWidget implements PreferredSizeWidget {
  const AppbarProfile({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.yellow,
      elevation: 1,
      title:
          const Text('Employee Profile', style: TextStyle(color: Colors.black)),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: const [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(AssetsData.profile),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
