import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFFF5F5DC);
  static const Color buttonGradientStart = Color(0xFFFCF6BA);
  static const Color buttonGradientEnd = Color(0xFFBF953A);
  static const Color buttonShadowColor = Color(0xFFAF7B1D);

  static const Color textFieldBorderColor = Color(0xFFB38728);

  static const Color appBarColor1 = Color(0xFFBF953F);
  static const Color appBarColor2 = Color(0xFFFCF6BA);
  static const Color appBarColor3 = Color(0xFFB38728);
  static const Color appBarColor4 = Color(0xFFFBF5B7);
  static const Color appBarColor5 = Color(0xFFAA771C);

  static const Color bottomNavBarColor1 = Color(0xffbf953f);
  static const Color bottomNavBarColor2 = Color(0xfffcf6ba);
  static const Color bottomNavBarColor3 = Color(0xffb38728);
  static const Color bottomNavBarColor4 = Color(0xffaa771c);

  static const Gradient appBarColorGradient = LinearGradient(colors: [
    appBarColor1,
    appBarColor2,
    appBarColor3,
    appBarColor4,
    appBarColor5
  ], begin: AlignmentDirectional.topStart, end: AlignmentDirectional.topEnd);

  static const Gradient bottomNavBarColorGradient = LinearGradient(colors: [
    bottomNavBarColor1,
    bottomNavBarColor2,
    bottomNavBarColor3,
    bottomNavBarColor2,
    bottomNavBarColor4
  ], begin: AlignmentDirectional.topStart, end: AlignmentDirectional.topEnd);
}
