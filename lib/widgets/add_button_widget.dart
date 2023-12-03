import 'package:flutter/material.dart';
import 'package:nurene_app/themes/app_colors.dart';

class AddButtonWidget extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const AddButtonWidget({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.appBarColor3),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
