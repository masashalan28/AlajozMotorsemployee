import 'package:flutter/material.dart';

class PasswordFields extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final VoidCallback togglePasswordVisibility;
  final VoidCallback toggleConfirmPasswordVisibility;
  final bool Function(String) isPasswordStrong;

  const PasswordFields({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.togglePasswordVisibility,
    required this.toggleConfirmPasswordVisibility,
    required this.isPasswordStrong,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: newPasswordController,
          onChanged: (_) => (context as Element).markNeedsBuild(),
          decoration: InputDecoration(
            labelText: 'New Password',
            prefixIcon: const Icon(Icons.lock),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: togglePasswordVisibility,
            ),
          ),
          obscureText: !isPasswordVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال كلمة المرور الجديدة';
            }
            if (value.length < 6) {
              return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
            }
            if (!isPasswordStrong(value)) {
              return 'كلمة المرور يجب أن تحتوي على حرف كبير وحرف صغير على الأقل';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        if (newPasswordController.text.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isPasswordStrong(newPasswordController.text)
                  ? Colors.green.shade50
                  : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isPasswordStrong(newPasswordController.text)
                    ? Colors.green
                    : Colors.orange,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isPasswordStrong(newPasswordController.text)
                      ? Icons.check_circle
                      : Icons.warning,
                  color: isPasswordStrong(newPasswordController.text)
                      ? Colors.green
                      : Colors.orange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isPasswordStrong(newPasswordController.text)
                        ? 'كلمة المرور قوية'
                        : 'كلمة المرور يجب أن تحتوي على حرف كبير وحرف صغير على الأقل',
                    style: TextStyle(
                      color: isPasswordStrong(newPasswordController.text)
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),
        TextFormField(
          controller: confirmPasswordController,
          decoration: InputDecoration(
            labelText: 'Confirm password',
            prefixIcon: const Icon(Icons.lock_outline),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: toggleConfirmPasswordVisibility,
            ),
          ),
          obscureText: !isConfirmPasswordVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء تأكيد كلمة المرور';
            }
            return null;
          },
        ),
      ],
    );
  }
}
