import 'package:AlajozMotorsemployee/features/home/presentation/views/widgets/appBar_Profile.dart';
import 'package:flutter/material.dart';
import 'widgets/body_Profile.dart';

class EmployeeProfile extends StatefulWidget {
  const EmployeeProfile({super.key});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  bool isEditable = false;

  void toggleEdit() {
    setState(() {
      isEditable = !isEditable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppbarProfile(),
      body: EmployeeProfileBody(
        isEditable: isEditable,
        toggleEdit: toggleEdit,
      ),
    );
  }
}
