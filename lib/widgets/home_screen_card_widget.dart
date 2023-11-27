import 'package:flutter/material.dart';
import 'package:nurene_app/themes/app_colors.dart';

class HomeScreenCard extends StatelessWidget {
  final String label;
  final Icon icon;

  const HomeScreenCard(
      {super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        AppColors.appBarColor3.withOpacity(0.8),
        AppColors.appBarColor4,
        AppColors.appBarColor5.withOpacity(0.8)
      ])),
      child: Row(
        children: [
          icon,
          Text(label,
              style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
