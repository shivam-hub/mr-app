import 'package:Nurene/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../utils/const.dart';

class DropDownWidget extends StatelessWidget {
  final MultiSelectController controller;
  final List<ValueItem> options;
  final String label;

  const DropDownWidget(
      {super.key,
      required this.controller,
      required this.options,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.appThemeDarkShade3,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: MultiSelectDropDown(
          onOptionSelected: (selectedOptions) {
            debugPrint(selectedOptions.toString());
          },
          options: Constants.states1,
          optionsBackgroundColor: Colors.white,
          borderColor: Colors.transparent,
          selectedOptionBackgroundColor: AppColors.appThemeLightShade3,
          hint: 'State',
          selectionType: SelectionType.single,
          searchEnabled: true,
          showChipInSingleSelectMode: false,
        ));
  }
}
