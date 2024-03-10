import 'package:Nurene/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              color: AppColors.appThemeDarkShade1, // Set underline border color
              width: 1.0, // Set the width of the underline border
            ),
          ),
        ),
        child: MultiSelectDropDown(
          onOptionSelected: (selectedOptions) {
            debugPrint(selectedOptions.toString());
          },
          options: options,
          optionsBackgroundColor: Colors.white,
          borderColor: Colors.transparent, // Set border color to transparent
          selectedOptionBackgroundColor: AppColors.appThemeLightShade3,
          hint: label,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          selectionType: SelectionType.single,
          searchEnabled: true,
          showChipInSingleSelectMode: false,
        ));
  }
}
