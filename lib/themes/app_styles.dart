import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/themes/app_colors.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.appThemeDarkShade3));
}

TextStyle get lisTitleStyle {
  return GoogleFonts.redHatDisplay(
      textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          shadows: [
            Shadow(
              color: Color.fromARGB(255, 201, 195, 195), // shadow color
              offset: Offset(5.0, 3.0), // shadow offset
              blurRadius: 10, // shadow blur radius
            ),
          ],
          fontSize: 20));
}
