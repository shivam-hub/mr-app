import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? prefixText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final GlobalKey<FormState>? formKey;
  final int? maxLines;
  final void Function(dynamic)? onChanged;


  const TextFieldWidget(
      {super.key,
      this.formKey,
      required this.label,
      required this.controller,
      this.isPassword = false,
      this.prefixText,
      this.readOnly = false,
      this.inputType,
      this.validator,
      this.onChanged,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      borderRadius: BorderRadius.circular(15),
      child: TextFormField(
        readOnly: readOnly,
        enabled: !readOnly,
        validator: validator,
        controller: controller,
        obscureText: isPassword,
        keyboardType: inputType,
        maxLines: isPassword ? 1 : maxLines,
        onChanged: (value) {
          if (formKey != null && formKey!.currentState != null) {
            formKey!.currentState!.validate();
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 237, 235, 216),
          labelText: label,
          prefixText: prefixText,
          floatingLabelStyle: const TextStyle(color: Colors.brown),
          enabledBorder: OutlineInputBorder(
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
