import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nurene_app/models/dropdown_value_model.dart';

import '../themes/app_colors.dart';

class DropdownTextFieldWidget extends StatefulWidget {
  final String placeholder;
  final List<DropDownOption> dropDownOption;
  final bool enableSearch;
  final void Function(dynamic)? onChanged;
  final String? prefixText;

  const DropdownTextFieldWidget(
      {super.key,
      required this.placeholder,
      required this.dropDownOption,
      this.enableSearch = true,
      this.onChanged,
      this.prefixText});

  @override
  State<DropdownTextFieldWidget> createState() =>
      _DropdownTextFieldWidgetState();
}

class _DropdownTextFieldWidgetState extends State<DropdownTextFieldWidget> {
  late SingleValueDropDownController _controller;

  @override
  void initState() {
    _controller = SingleValueDropDownController();
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
        enableSearch: widget.enableSearch,
        controller: _controller,
        onChanged: widget.onChanged,
        textFieldDecoration: InputDecoration(
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
