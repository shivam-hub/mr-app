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

  // new changes

  static const Color appThemeDarkShade1 = Color.fromARGB(255, 0, 75, 35);
  static const Color appThemeDarkShade2 = Color.fromARGB(255, 0, 100, 0);
  static const Color appThemeDarkShade3 = Color.fromARGB(255, 0, 114, 0);
  static const Color appThemeDarkShade4 = Color.fromARGB(255, 0, 128, 0);
  static const Color appThemeLightShade1 = Color.fromARGB(255, 56, 176, 0);
  static const Color appThemeLightShade2 = Color.fromARGB(255, 112, 224, 0);
  static const Color appThemeLightShade3 = Color.fromARGB(255, 158, 240, 26);
  static const Color appThemeLightShade4 = Color.fromARGB(255, 204, 255, 51);

  static const Gradient appBarColorGradient = LinearGradient(
    colors: [appThemeDarkShade4, appThemeLightShade1, appThemeLightShade2],
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.topEnd,
  );

  static const Gradient buttonGradient = LinearGradient(
    colors: [
      appThemeDarkShade3,
      appThemeDarkShade4,
      appThemeLightShade1,
      appThemeLightShade2
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient gradient = LinearGradient(
    colors: [
      appThemeDarkShade1,
      appThemeDarkShade3,
      appThemeLightShade1,
      appThemeLightShade3,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
