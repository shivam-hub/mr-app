import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nurene_app/themes/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final BorderRadius? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final String label;
  final double? labelFontSize;

  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.label,
    this.borderRadius,
    this.width = 150,
    this.height = 50,
    this.labelFontSize = 22,
    this.gradient = const LinearGradient(
        colors: [AppColors.buttonGradientStart, AppColors.buttonGradientEnd],
        begin: AlignmentDirectional.bottomCenter,
        end: AlignmentDirectional.topCenter),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(50);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 159, 170, 205), blurRadius: 5.0)
          ]),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            elevation: 5),
        child: Text(
          label,
          style: GoogleFonts.cormorantGaramond(
              color: Colors.white,
              fontSize: labelFontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
