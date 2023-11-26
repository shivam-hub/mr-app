import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nurene_app/models/dropdown_value_model.dart';

class DropdownTextFieldWidget extends StatefulWidget {
  final String placeholder;
  final List<DropDownOption> dropDownOption;
  final bool enableSearch;

  const DropdownTextFieldWidget({
    super.key,
    required this.placeholder,
    required this.dropDownOption,
    this.enableSearch = true,
  });

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
    return DropDownTextField(
      dropDownList: widget.dropDownOption,
      enableSearch: widget.enableSearch,
      controller: _controller,
    );
  }
}
