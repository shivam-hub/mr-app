import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final String appBarTitle;
  final Widget? logo;
  final Gradient? gradient;
  final Icon? prefixIcon;

  const AppBarWidget(
      {super.key,
      required this.appBarTitle,
      this.gradient,
      this.logo,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: logo,
      title: Text(
        appBarTitle,
        style: const TextStyle(
            color: Colors.brown, fontSize: 28, fontWeight: FontWeight.bold),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: gradient
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
