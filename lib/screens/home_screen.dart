import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/blocs/home/home_event.dart';
import 'package:intl/intl.dart';
import '../blocs/home/home_state.dart';
import '../models/user_model.dart';
import '../screens/plan_visit_screen.dart';
import '../services/api_services.dart';
import '../services/locator.dart';
import '../themes/app_colors.dart';
import '../widgets/add_button_widget.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/bottom_navigationbar_widget.dart';
import '../widgets/home_screen_cards.dart';
import '../widgets/logo_widget.dart';
import '../blocs/home/home_bloc.dart';
import '../utils/Priority.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  Priority _getPriority(String priority) {
    switch (priority.toLowerCase()) {
      case "low":
        return Priority.low;

      case "medium":
        return Priority.medium;

      case "high":
        return Priority.high;

      default:
        return Priority.low;
    }
  }

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
      body: BlocProvider(
        create: (context) => HomeScreenBloc(locator<ApiService>()),
        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
          return Column(
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
                    BlocProvider.of<HomeScreenBloc>(context)
                        .add(HomeScreenLoadingEvent());
                    debugPrint('$_selectedDate');
                  },
                ),
              ),
              if (state is HomeScreenLoadingState) ...{
                const CircularProgressIndicator(),
              } else if (state is DataFetchedState) ...{
                Expanded(
                  child: ListView.builder(
                    itemCount: state.schedules.length,
                    itemBuilder: (_, context) {
                      final schedules = state.schedules;
                      return Column(
                        children: schedules
                            .where((schedule) =>
                                DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                    schedule['plannedVisitDate'])) ==
                                DateFormat('yyyy-MM-dd').format(_selectedDate))
                            .map((filteredSchedule) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: CardWidget(
                              time: filteredSchedule['plannedVisitTime'],
                              doctorName: filteredSchedule['doctorInfo']
                                  ['name'],
                              clinicName: filteredSchedule['doctorInfo']
                                  ['clinicName'],
                              priority:
                                  _getPriority(filteredSchedule['priorty']),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                )
              }
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        gradientB: AppColors.bottomNavBarColorGradient,
      ),
    );
  }
}
