import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:nurene_app/blocs/plan_visit/plan_visit_event.dart';
import 'package:nurene_app/blocs/plan_visit/plan_visit_state.dart';
import 'package:nurene_app/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/plan_visit_model.dart';

class PlanVisitBloc extends Bloc<PlanVisitEvent, PlanVisitState> {
  final ApiService apiService;
  PlanVisitBloc(this.apiService) : super(PlanVisitInitialState());

  @override
  Stream<PlanVisitState> mapEventToState(PlanVisitEvent event) async* {
    if (event is DoctorSelectedEvent) {
      yield DoctorSelectedState(event.doctorDetails);
      // Handle the logic for doctor selection here
      // yield PlanVisitLoadingState(); // You can emit a loading state if needed

      // Perform any asynchronous tasks here (e.g., fetching address based on the doctor)
      // try {
      //   // Simulate loading data
      //   await Future.delayed(const Duration(seconds: 2));
      //   // Update the state with the selected doctor
      //   yield PlanVisitSuccessState();
      // } catch (e) {
      //   yield PlanVisitErrorState('Error selecting doctor');
      // }
    } else if (event is SavePlanVisitDataEvent) {
      // Handle the logic for saving data here
      yield PlanVisitLoadingState(); // You can emit a loading state if needed

      // Perform any asynchronous tasks here (e.g., saving data to the backend)
      try {
        final payload = <String, dynamic>{};
        final pref = await SharedPreferences.getInstance();

        final userDetailsStr = pref.getString('userDetails') ?? '';
        final Map<String, dynamic> userDetails = json.decode(userDetailsStr);
        final doctorDetails = DoctorInfo.fromJson(event.doctorDetails);

        payload['mrId'] = userDetails['userId'];
        payload['doctorInfo'] = doctorDetails.toJson();
        payload['plannedVisitDate'] = event.date;
        payload['plannedVisitTime'] = event.time;

        final isSaved = await apiService.scheduleVisit(json.encode(payload));

        yield PlanVisitSuccessState();
      } catch (e) {
        yield PlanVisitErrorState('Error saving data');
      }
    }
  }
}
