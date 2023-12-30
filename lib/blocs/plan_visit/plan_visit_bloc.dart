import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:nurene_app/blocs/plan_visit/plan_visit_event.dart';
import 'package:nurene_app/blocs/plan_visit/plan_visit_state.dart';
import 'package:nurene_app/models/user_model.dart';
import 'package:nurene_app/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/doctor_model.dart';

class PlanVisitBloc extends Bloc<PlanVisitEvent, PlanVisitState> {
  final ApiService apiService;
  PlanVisitBloc(this.apiService) : super(PlanVisitInitialState());

  @override
  Stream<PlanVisitState> mapEventToState(PlanVisitEvent event) async* {
    if (event is DoctorSelectedEvent) {
      yield DoctorSelectedState(event.doctorDetails);
    } else if (event is SavePlanVisitDataEvent) {
      yield PlanVisitLoadingState();

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
        final user = pref.getString('userDetails') ?? '';
        yield PlanVisitSuccessState(isSaved, UserModel.fromJson(json.decode(user)));
      } catch (e) {
        yield PlanVisitErrorState('Error saving data');
      }
    }
  }
}
