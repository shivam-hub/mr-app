import 'package:flutter/material.dart';
import 'package:nurene_app/models/user_model.dart';
import 'package:nurene_app/screens/master_screen.dart';
import 'package:nurene_app/screens/plan_visit_screen.dart';
import 'package:nurene_app/themes/app_colors.dart';
import 'package:nurene_app/widgets/appbar_widget.dart';
import 'package:nurene_app/widgets/bottom_navigationbar_widget.dart';
import 'package:nurene_app/widgets/home_screen_card_widget.dart';
import 'package:nurene_app/widgets/logo_widget.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: const AppBarWidget(
              logo: LogoWidget(
                height: 8,
                width: 8,
              ),
              appBarTitle: "Nurene",
              gradient: AppColors.appBarColorGradient,
            ),
            body: Column(
              children: [
                const SizedBox(height: 80),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("   Hello User,",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PlanVisitScreen()));
                      },
                      child: const HomeScreenCard(
                        label: "label",
                        icon: Icon(Icons.abc_rounded),
                      ),
                    ),
                    GestureDetector(
                      onTap:  () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MasterScreen()));
                      },
                      child: const HomeScreenCard(
                          label: "label", icon: Icon(Icons.abc_rounded)),
                    )
                  ],
                ),
              ],
            ),
            bottomNavigationBar:
                const Stack(children: [BottomNavigationBarWidget()])));
  }
}
