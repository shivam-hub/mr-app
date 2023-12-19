import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurene_app/themes/app_colors.dart';

import '../screens/master_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  int? selectedIndex;
  final Gradient? gradientB;
  BottomNavigationBarWidget({super.key, this.gradientB, this.selectedIndex});

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
                  onTap: (int selectedIndex) {
                    switch (selectedIndex) {
                      case 0:
                        // Handle tap on the 'Plan' item
                        // You can navigate to another screen or perform any other action
                        print('Plan tapped');
                        break;
                      case 1:
                        // Handle tap on the 'Home' item
                        print('Home tapped');
                        break;
                      case 2:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MasterScreen()));
                        break;
                    }
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.edit_note_rounded), label: 'Plan'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.manage_accounts_rounded),
                        label: 'Profile'),
                  ],
                  
                  unselectedItemColor: Colors.brown,
                  
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
