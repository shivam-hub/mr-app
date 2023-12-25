import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/blocs/home/home_event.dart';
import 'package:intl/intl.dart';
import '../blocs/home/home_state.dart';
import '../models/plan_visit_model.dart';
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
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenBloc(locator<ApiService>()),
      child: _HomeScreenContent(user: user),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  final UserModel user;

  const _HomeScreenContent({Key? key, required this.user}) : super(key: key);

  @override
  State<_HomeScreenContent> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreenContent> {
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
  void initState() {
    super.initState();
    BlocProvider.of<HomeScreenBloc>(context).add(HomeScreenInitialEvent());
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
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
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
                            builder: (context) => const PlanVisitScreen(),
                          ),
                        );
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
                    setState(() {
                      _selectedDate = date;
                    });
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
                    itemCount: state.schedules
                        .where(
                          (schedule) =>
                              DateFormat('yyyy-MM-dd').format(
                                DateTime.parse(schedule['plannedVisitDate'])
                                    .toLocal(),
                              ) ==
                              DateFormat('yyyy-MM-dd').format(_selectedDate),
                        )
                        .length,
                    itemBuilder: (context, index) {
                      final filteredSchedules = state.schedules
                          .where(
                            (schedule) =>
                                DateFormat('yyyy-MM-dd').format(
                                  DateTime.parse(schedule['plannedVisitDate'])
                                      .toLocal(),
                                ) ==
                                DateFormat('yyyy-MM-dd').format(_selectedDate),
                          )
                          .toList();

                      final scheduleModel =
                          PlanVisitModel.fromJson(filteredSchedules[index]);
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: CardWidget(
                          time: scheduleModel.plannedVisitTime ?? "",
                          doctorName: scheduleModel.doctorInfo?.name ?? "",
                          clinicName:
                              scheduleModel.doctorInfo?.clinicName ?? "",
                          priority: _getPriority(scheduleModel.priority ?? ""),
                        ),
                      );
                    },
                  ),
                )
              }
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        gradientB: AppColors.bottomNavBarColorGradient,
      ),
    );
  }
}
