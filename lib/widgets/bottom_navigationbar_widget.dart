import 'package:flutter/material.dart';
import 'package:nurene_app/screens/home_screen.dart';
import 'package:nurene_app/screens/master_screen.dart';
import 'package:nurene_app/screens/plan_visit_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Gradient? gradientB;

  BottomNavigationBarWidget({Key? key, this.gradientB}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

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
                    switch (selectedIndex) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlanVisitScreen(),
                          ),
                        );
                        break;
                      case 1:
                        print("home");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => HomeScreen(user: null),
                        //   ),
                        // );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MasterScreen(),
                          ),
                        );
                        break;
                    }
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
}
