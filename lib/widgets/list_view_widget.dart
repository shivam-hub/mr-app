import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

// ignore: use_key_in_widget_constructors
class ListViewWidget extends StatelessWidget {
  // final String date;
  // final String planName;
  // final String doctorName;

  //const ListViewWidget({super.key, required this.date,  this.planName = "You dont have any visit request",  this.doctorName = "You dont have any visit request"});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return const ListTile(
          title: Text('hello'),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
        );
      },
      itemCount: 4,
    );
  }
}
