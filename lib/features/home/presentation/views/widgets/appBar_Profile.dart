import 'package:AlajozMotorsemployee/core/utils/assets.dart';
import 'package:flutter/material.dart';

class AppbarProfile extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onRefresh;

  const AppbarProfile({
    super.key,
    this.onRefresh,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.yellow,
      elevation: 1,
      title:
          const Text('Employee Profile', style: TextStyle(color: Colors.black)),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        if (onRefresh != null)
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRefresh,
            tooltip: 'تحديث البروفايل',
          ),
        const Padding(
          padding: EdgeInsets.only(right: 12),
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
