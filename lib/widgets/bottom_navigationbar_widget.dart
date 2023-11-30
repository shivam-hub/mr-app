import 'package:flutter/material.dart';
import 'package:nurene_app/themes/app_colors.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Gradient? gradientB;
  const BottomNavigationBarWidget({super.key, this.gradientB});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(80, 0, 80, 20),
          child: Align(
            alignment: const Alignment(1, 1),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              child: Container(
                decoration: BoxDecoration(gradient: widget.gradientB),
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.edit_note_rounded), label: 'Plan'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.manage_accounts_rounded),
                        label: 'Profile'),
                  ],
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.brown,
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
