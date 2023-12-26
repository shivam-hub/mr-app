import 'package:flutter/material.dart';
import 'package:nurene_app/screens/master_screen.dart';
import 'package:nurene_app/screens/plan_visit_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Gradient? gradientB;
  final int initialIndex;

  BottomNavigationBarWidget({
    Key? key,
    this.gradientB,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

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
                  currentIndex: _selectedIndex,
                  onTap: (int selectedIndex) {
                    setState(() {
                      _selectedIndex = selectedIndex;
                    });
                    navigateToScreen(selectedIndex);
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.calendar_today,
                        color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: _selectedIndex == 2 ? Colors.black : Colors.grey,
                      ),
                      label: '',
                    ),
                  ],
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                  showUnselectedLabels: false,
                  selectedIconTheme: IconThemeData(size: 28),
                  unselectedIconTheme: IconThemeData(size: 28),
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

  void navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlanVisitScreen(),
          ),
        ).then((_) {
          // Update _selectedIndex when navigating back from PlanVisitScreen
          setState(() {
            _selectedIndex = 0;
          });
        });
        break;
      case 1:
        // Handle other cases as needed
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MasterScreen(),
          ),
        ).then((_) {
          // Update _selectedIndex when navigating back from MasterScreen
          setState(() {
            _selectedIndex = 2;
          });
        });
        break;
    }
  }
}
