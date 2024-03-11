import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final bool isLoginScreen;

  const LogoWidget({super.key, this.width, this.height, this.isLoginScreen = false});

  @override
  Widget build(BuildContext context) {
    return Image.asset(isLoginScreen ? 'asset/images/nurene_full_logo.png' : 'asset/images/nurene_logo.png',
        width: width ?? 120, height: height ?? 120);
  }
}
