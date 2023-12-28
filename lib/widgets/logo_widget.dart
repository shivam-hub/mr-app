import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const LogoWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset('asset/images/nurene_logo.png',
        width: width ?? 120, height: height ?? 120);
  }
}
