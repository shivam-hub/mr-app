import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nurene_app/models/dropdown_value_model.dart';
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
      dropDownList: widget.dropDownOption,
      dropdownColor: const Color.fromARGB(255, 236, 232, 185),
      enableSearch: widget.readonly ? widget.enableSearch : false,
      readOnly: widget.readonly,
      isEnabled: !widget.readonly,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      textFieldDecoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent, // Transparent to see the shadow
        labelText: widget.placeholder,
        prefixText: widget.prefixText,
        floatingLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 83, 69, 116)), // Change label text color
        enabledBorder: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Color(0xFF7882A4)), // Change underline color
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Color(0xFF7882A4)), // Change focused underline color
        ),
      ),
    );
  }
}
