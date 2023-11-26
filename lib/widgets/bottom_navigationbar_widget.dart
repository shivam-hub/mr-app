import 'package:flutter/material.dart';
import 'package:nurene_app/themes/app_colors.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        margin: const EdgeInsets.fromLTRB(80, 0, 80, 18),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            gradient: LinearGradient(colors: [
              AppColors.appBarColor1,
              AppColors.appBarColor2,
              AppColors.appBarColor3
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.schedule_rounded)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.home_mini_rounded)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.format_paint))
          ],
        ),
      ),
    );
  }
}
