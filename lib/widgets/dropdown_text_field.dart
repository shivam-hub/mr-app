import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nurene_app/models/dropdown_value_model.dart';

import '../themes/app_colors.dart';

class DropdownTextFieldWidget extends StatefulWidget {
  final String placeholder;
  final List<DropDownOption> dropDownOption;
  final bool enableSearch;
  final bool readonly;
  final SingleValueDropDownController controller;
  final void Function(dynamic)? onChanged;
  final String? prefixText;

  const DropdownTextFieldWidget(
      {super.key,
      required this.placeholder,
      required this.dropDownOption,
      this.enableSearch = true,
      this.onChanged,
      required this.controller,
      this.readonly = false,
      this.prefixText});

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
    return Material(
      elevation: 15,
      borderRadius: BorderRadius.circular(15),
      child: DropDownTextField(
        dropDownList: widget.dropDownOption,
        dropdownColor: const Color.fromARGB(255, 236, 232, 185),
        enableSearch: widget.readonly ? widget.enableSearch : false,
        readOnly: widget.readonly,
        isEnabled: !widget.readonly,
        controller: widget.controller,
        onChanged: widget.onChanged,
        textFieldDecoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 237, 235, 216),
          labelText: widget.placeholder,
          prefixText: widget.prefixText,
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
