import 'package:flutter/material.dart';
import '/themes/app_colors.dart';

class AddButtonWidget extends StatelessWidget {
  final Function()? onTap;
  const AddButtonWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 5,
        onPressed: onTap,
        backgroundColor: AppColors.newColor,
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          // child: Container(
          //   width: 100,
          //   height: 40,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //       color: AppColors.newColor),

          //       // child: Text(
          //       //   label,
          //       //   style: const TextStyle(color: Colors.white),
          //       // ),
          //       ),
        ));
  }
}
