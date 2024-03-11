import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/models/dropdown_value_model.dart';
import '../themes/app_colors.dart';

class DropdownTextFieldWidget extends StatefulWidget {
  final String placeholder;
  final List<DropDownOption> dropDownOption;
  final bool enableSearch;
  final bool readonly;
  final SingleValueDropDownController? controller;

  final void Function(dynamic)? onChanged;
  final String? prefixText;
  final String? Function(String?)? validator;

  const DropdownTextFieldWidget({
    super.key,
    required this.placeholder,
    required this.dropDownOption,
    this.enableSearch = true,
    this.onChanged,
    this.controller,
    this.readonly = false,
    this.validator,
    this.prefixText,
  });

  @override
  State<DropdownTextFieldWidget> createState() =>
      _DropdownTextFieldWidgetState();
}

class _DropdownTextFieldWidgetState extends State<DropdownTextFieldWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      textStyle: GoogleFonts.montserrat(),
      dropDownList: widget.dropDownOption,
      dropdownColor: const Color.fromARGB(255, 237, 245, 214),
      enableSearch: widget.readonly ? widget.enableSearch : false,
      searchAutofocus: true,
      dropdownRadius: 0,
      readOnly: widget.readonly,
      isEnabled: !widget.readonly,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      textFieldDecoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        labelText: widget.placeholder,
        labelStyle: GoogleFonts.montserrat(),
        prefixText: widget.prefixText,
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
    );
  }
}
