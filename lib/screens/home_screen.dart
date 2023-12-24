import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:nurene_app/models/user_model.dart';
import 'package:nurene_app/screens/plan_visit_screen.dart';
import 'package:nurene_app/themes/app_colors.dart';
import 'package:nurene_app/widgets/add_button_widget.dart';
import 'package:nurene_app/widgets/appbar_widget.dart';
import 'package:nurene_app/widgets/bottom_navigationbar_widget.dart';
import 'package:nurene_app/widgets/home_screen_cards.dart';
import 'package:nurene_app/widgets/logo_widget.dart';
import 'package:intl/intl.dart';
// import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: false,
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
          Container(
            padding: const EdgeInsets.only(top: 20),
            margin: const EdgeInsets.only(left: 15, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                      ),
                      const Text(
                        "Today",
                      )
                    ],
                  ),
                ),
                AddButtonWidget(
                  label: '+ Plan Visit',
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlanVisitScreen()));
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 15),
            child: DatePicker(
              DateTime.now(),
              height: 80,
              width: 60,
              initialSelectedDate: DateTime.now(),
              selectionColor: AppColors.appBarColor3,
              selectedTextColor: Colors.white70,
              dateTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
              onDateChange: (date) {
                _selectedDate = date;
                debugPrint('$_selectedDate');
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                // itemCount: _taskController.tasklist.length,
                itemCount: 10,
                itemBuilder: (_, context) {
                  return const Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: CardWidget(
                        time: "2023-12-22T14:15:00.000+00:00",
                        doctorName: "Shivam",
                        clinicName: "Test",
                      ));
                }),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        gradientB: AppColors.bottomNavBarColorGradient,
      ),
    );
  }
}
