import 'package:flutter/material.dart';

class AppColors {
  // static const Color backgroundColor = Color(0xFFF5F5DC);
  static const Color backgroundColor = Color.fromARGB(255, 255, 255, 255);
  static const Color buttonGradientStart = Color(0xFFFCF6BA);
  static const Color buttonGradientEnd = Color(0xFFBF953A);
  static const Color buttonShadowColor = Color(0xFFAF7B1D);

  static const Color newColor = Colors.indigo;
  static const Color newColorText = Color.fromARGB(221, 36, 35, 35);
  static const Color newColorText1 = Color.fromARGB(221, 97, 96, 96);
  static const Color textFieldBorderColor = Color(0xFF7882A4);

  static const Color appBarColor1 = Color(0xFFBF953F);
  static const Color appBarColor2 = Color(0xFFFCF6BA);
  static const Color appBarColor3 = Color(0xFFB38728);
  static const Color appBarColor4 = Color(0xFFFBF5B7);
  static const Color appBarColor5 = Color(0xFFAA771C);

  static const Color bottomNavBarColor1 = Color(0xffbf953f);
  static const Color bottomNavBarColor2 = Color(0xfffcf6ba);
  static const Color bottomNavBarColor3 = Color(0xffb38728);
  static const Color bottomNavBarColor4 = Color(0xffaa771c);
  //background-image: linear-gradient(45deg, #7882A4, #E4AEC5);
  static const Gradient appBarColorGradient = LinearGradient(
    colors: [
      // Color(0xFF370665),
      // Color(0xFFC56183),
      Color(0xFF7882A4),
      Color(0xFFE4AEC5),
    ],
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.topEnd,
  );

  // static const Gradient appBarColorGradient = LinearGradient(colors: [
  //   appBarColor1,
  //   appBarColor2,
  //   appBarColor3,
  //   appBarColor4,
  //   appBarColor5
  // ], begin: AlignmentDirectional.topStart, end: AlignmentDirectional.topEnd);

  static const Gradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFF7882A4),
      Color.fromARGB(255, 159, 170, 205),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
