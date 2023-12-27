import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nurene_app/themes/app_colors.dart';

import '../screens/master_screen.dart';

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
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Handle search button press
            print('Search button pressed');
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Handle notifications button press
            print('Notifications button pressed');
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MasterScreen(),
              ),
            );
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(color: AppColors.newColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
