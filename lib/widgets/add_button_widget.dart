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
        backgroundColor: Colors.white,
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
