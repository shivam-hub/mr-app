import 'package:flutter/material.dart';
import 'package:nurene_app/themes/app_colors.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children:[
        Padding(
          padding: const EdgeInsets.fromLTRB(200,0,200,20),
          child: Align(
            alignment: Alignment(1,1),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30),),
            child: BottomNavigationBar(items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label:'home'),
               BottomNavigationBarItem(icon: Icon(Icons.home), label:'home'),
                BottomNavigationBarItem(icon: Icon(Icons.home), label:'home'),
            ],
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            backgroundColor: Colors.brown,
           ),  
            ),
            ),
        ),

      ],
    );
  }
}
