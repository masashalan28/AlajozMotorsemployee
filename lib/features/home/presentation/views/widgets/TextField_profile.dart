import 'package:flutter/material.dart';

class EmployeeTextField extends StatelessWidget {
  final String value;
  final bool isEditable;

  const EmployeeTextField(
      {super.key, required this.value, required this.isEditable});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );

    return TextFormField(
      initialValue: value,
      readOnly: !isEditable,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
            //borderSide: const BorderSide(color: Colors.yellow),
            ),
      ),
    );
  }
}
