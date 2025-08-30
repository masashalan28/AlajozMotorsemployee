import 'package:AlajozMotorsemployee/core/utils/assets.dart';
import 'package:flutter/material.dart';

import 'TextField_profile.dart';

class EmployeeProfileBody extends StatelessWidget {
  final bool isEditable;
  final VoidCallback toggleEdit;
  const EmployeeProfileBody({
    super.key,
    required this.isEditable,
    required this.toggleEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Employee Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(AssetsData.profile),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("@John.Doe",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Edit profile",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      IconButton(
                        icon: Icon(isEditable ? Icons.check : Icons.edit,
                            color: Colors.black),
                        onPressed: toggleEdit,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildLabel("Full name"),
                  EmployeeTextField(value: "John Doe", isEditable: isEditable),
                  buildLabel("Employee ID"),
                  EmployeeTextField(value: "E123456", isEditable: isEditable),
                  buildLabel("Contact number"),
                  EmployeeTextField(
                      value: "+00 987 654 321", isEditable: isEditable),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabel("Date of joining"),
                            EmployeeTextField(
                                value: "01/15/2020", isEditable: isEditable),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabel("Department"),
                            EmployeeTextField(
                                value: "Marketing", isEditable: isEditable),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildLabel("Skills"),
                  EmployeeTextField(
                    value: "SEO, Content Creation, Analytics",
                    isEditable: isEditable,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
