import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final Widget? logo;
  final Gradient? gradient;
  final IconButton? prefixIcon;

  const AppBarWidget(
      {super.key,
      required this.appBarTitle,
      this.gradient,
      this.logo,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: logo ?? prefixIcon,
      title: Text(
        appBarTitle,
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: gradient),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
