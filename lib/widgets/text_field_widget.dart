import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? prefixText;

  const TextFieldWidget({super.key, 
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixText: prefixText,
          floatingLabelStyle: const TextStyle(
            color: Colors.brown
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.textFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.textFieldBorderColor),
          ),
        ),
      ),
    );
  }
}
