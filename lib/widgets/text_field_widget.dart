import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? prefixText;
  final bool readOnly;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.prefixText,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Material(
        elevation: 15,
        borderRadius: BorderRadius.circular(15),
        child: TextField(
          readOnly: readOnly,
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: label,
            prefixText: prefixText,
            floatingLabelStyle: const TextStyle(color: Colors.brown),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.textFieldBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.textFieldBorderColor),
            ),
          ),
        ),
      ),
    );
  }
}
