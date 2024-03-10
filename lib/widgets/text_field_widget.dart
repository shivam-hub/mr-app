import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final bool? isCapitalized;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final void Function(dynamic)? onChanged;

  const TextFieldWidget(
      {Key? key,
      required this.label,
      required this.controller,
      this.isPassword = false,
      this.prefixText,
      this.readOnly = false,
      this.inputType,
      this.validator,
      this.onChanged,
      this.maxLines,
      this.minLines,
      this.focusNode,
      this.maxLength,
      this.isCapitalized})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        TextFormField(
          style: GoogleFonts.montserrat(),
          maxLength: maxLength,
          readOnly: readOnly,
          enabled: !readOnly,
          validator: validator,
          controller: controller,
          obscureText: isPassword,
          keyboardType: inputType,
          textCapitalization: isCapitalized ?? false
              ? TextCapitalization.words
              : TextCapitalization.none,
          focusNode: focusNode,
          minLines: minLines,
          maxLines: isPassword ? 1 : maxLines,
          decoration: InputDecoration(
            labelStyle: GoogleFonts.montserrat(),
            filled: true,
            fillColor: Colors.transparent,
            labelText: label,
            prefixText: prefixText,
            floatingLabelStyle: GoogleFonts.montserrat(
              color: AppColors.appThemeDarkShade1,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.appThemeDarkShade1,
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.appThemeDarkShade1,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
