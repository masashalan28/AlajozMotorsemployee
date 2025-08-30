import 'package:flutter/material.dart';

class GetStartedSubtitle extends StatelessWidget {
  const GetStartedSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Manage your work tasks easily',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
      ),
    );
  }
}