import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Colors.white;
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
