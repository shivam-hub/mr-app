import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../../blocs/home/home_bloc.dart';
import '../../blocs/home/home_event.dart';
import '../../blocs/home/home_state.dart';
import '../../models/plan_visit_model.dart';
import '../../models/user_model.dart';
import '../../services/api_services.dart';
import '../../services/locator.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_styles.dart';
import '../../utils/Priority.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/dashed_divider_widget.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/home_screen_cards.dart';
import '../../widgets/logo_widget.dart';

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
      endDrawer: const MyDrawer(),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildDateHeader(),
              _buildDatePicker(),
              const DashedDivider(),
              _buildScheduleList(state),
            ],
          );
        },
      ),
      // floatingActionButton: AddButtonWidget(
      //   onTap: () async {
      //     await Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const PlanVisitScreen(),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  Widget _buildDateHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      margin: const EdgeInsets.only(left: 15, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today",
                  style: subHeadingStyle,
                ),
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: headingStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, bottom: 20),
      child: DatePicker(
        DateTime.now(),
        height: 95,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: AppColors.appThemeLightShade1,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.nunitoSans(
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.nunito(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: Colors.grey,
          ),
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
    );
  }

  Widget _buildScheduleList(HomeScreenState state) {
    if (state is HomeScreenLoadingState) {
      return const CircularProgressIndicator(
            color: AppColors.appThemeLightShade1,
      );
    } else if (state is DataFetchedState) {
      return Expanded(
        child: ListView.builder(
          itemCount: state.schedules
              .where(
                (schedule) =>
                    DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(schedule['plannedVisitDate']).toLocal(),
                    ) ==
                    DateFormat('yyyy-MM-dd').format(_selectedDate),
              )
              .length,
          itemBuilder: (context, index) {
            final filteredSchedules = state.schedules
                .where(
                  (schedule) =>
                      DateFormat('yyyy-MM-dd').format(
                        DateTime.parse(schedule['plannedVisitDate']).toLocal(),
                      ) ==
                      DateFormat('yyyy-MM-dd').format(_selectedDate),
                )
                .toList();

            final scheduleModel =
                PlanVisitModel.fromJson(filteredSchedules[index]);
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: CardWidget(
                  doctorName: scheduleModel.doctorInfo?.name ?? "",
                  clinicName: scheduleModel.doctorInfo?.clinicName ?? "",
                  priority: _getPriority(scheduleModel.priority ?? ""),
                  scheduleVisitId: scheduleModel.scheduleId ?? '',
                  isVisited: scheduleModel.isVisited ?? false,
                  doctorId: scheduleModel.doctorInfo?.drId ?? ''),
            );
          },
        ),
      );
    }
    return const SizedBox();
  }

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
}
