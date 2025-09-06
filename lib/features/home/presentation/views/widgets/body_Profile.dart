import 'package:AlajozMotorsemployee/core/utils/assets.dart';
import 'package:flutter/material.dart';
import '../../../../auth/data/models/user_model.dart';

import 'TextField_profile.dart';

class EmployeeProfileBody extends StatelessWidget {
  final bool isEditable;
  final VoidCallback toggleEdit;
  final VoidCallback? cancelEdit;
  final UserModel? userData;

  const EmployeeProfileBody({
    super.key,
    required this.isEditable,
    required this.toggleEdit,
    this.cancelEdit,
    this.userData,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData?.name ?? "Loading...",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text("Edit profile",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildLabel("Full name"),
                  EmployeeTextField(
                    value: userData?.name ?? "Loading...",
                    isEditable: false,
                  ),
                  buildLabel("Phone number"),
                  EmployeeTextField(
                    value: userData?.phone ?? "Loading...",
                    isEditable: false,
                  ),
                  buildLabel("Email"),
                  EmployeeTextField(
                    value: userData?.email ?? "Loading...",
                    isEditable: false,
                  ),
                  buildLabel("Salary"),
                  EmployeeTextField(
                    value: userData?.salary != null
                        ? "${userData!.salary} SYP"
                        : "Loading...",
                    isEditable: false,
                  ),
                  buildLabel("Hired Date"),
                  EmployeeTextField(
                    value: userData?.hiredDate != null
                        ? "${userData!.hiredDate!.day}/${userData!.hiredDate!.month}/${userData!.hiredDate!.year}"
                        : "Loading...",
                    isEditable: false,
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
