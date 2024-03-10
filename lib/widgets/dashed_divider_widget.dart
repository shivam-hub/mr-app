import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: const Divider(
        color: Color.fromARGB(255, 205, 203, 203),
        thickness: 1.0,
        height: 1.0,
        indent: 20.0,
        endIndent: 20.0,
      ),
    );
  }
}
