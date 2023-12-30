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
  final FocusNode? focusNode;

  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final void Function(dynamic)? onChanged;

  const TextFieldWidget(
      {Key? key,
      // this.formKey,
      required this.label,
      required this.controller,
      this.isPassword = false,
      this.prefixText,
      this.readOnly = false,
      this.inputType,
      this.validator,
      this.onChanged,
      this.maxLines,
      this.minLines, this.focusNode, this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        TextFormField(
          maxLength: maxLength,
          readOnly: readOnly,
          enabled: !readOnly,
          validator: validator,
          controller: controller,
          obscureText: isPassword,
          keyboardType: inputType,
          focusNode: focusNode,
          minLines: minLines,
          maxLines: isPassword ? 1 : maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent, // Transparent to see the shadow
            labelText: label,
            prefixText: prefixText,
            floatingLabelStyle: const TextStyle(
              color: Color.fromARGB(255, 83, 69, 116),
            ), // Change label text color
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7882A4), // Change underline color
                style: BorderStyle.solid, // Keep the border style constant
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7882A4), // Change focused underline color
                style: BorderStyle.solid, // Keep the border style constant
              ),
            ),
          ),
        ),
      ],
    );
  }
}
