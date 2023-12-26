import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import '/models/visit_model.dart';
import '/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'master_event.dart';
import 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  final ApiService apiService;
  MasterBloc(this.apiService) : super(MasterInitialState());

  @override
  Stream<MasterState> mapEventToState(MasterEvent event) async* {
    if (event is DoctorSelectedEvent) {
      yield DoctorSelectedState(event.doctorDetails);
    } else if (event is SaveMasterDataEvent) {
      try {
        final pref = await SharedPreferences.getInstance();
        final userDetailsStr = pref.getString('userDetails') ?? '';
        final Map<String, dynamic> userDetails = json.decode(userDetailsStr);
        final doctorDetails = DoctorInfo.fromJson(event.doctorDetails);
        final longitude = pref.getDouble('longitude') ?? 0;
        final latitude = pref.getDouble('latitude') ?? 0;
        final location = <String, dynamic>{};
        location['type'] = 'Point';
        location['coordinates'] = <double>[longitude, latitude];
        final payload = <String, dynamic>{};
        payload['mrId'] = userDetails['userId'];
        payload['location'] = location;
        payload['doctorInfo'] = doctorDetails.toJson();
        payload['mrInfo'] = userDetails;
        final c = VisitModel.fromJson(payload);
        final isSaved =
            await apiService.saveMasterDetails(json.encode(payload));
        yield MasterSuccessState();
      } catch (e) {
        yield MasterErrorState('Error saving data: $e');
      }
    } else if (event is NewDoctorRecordEvent) {
      yield NewDoctorRecordState();
    } else if (event is MasterFormReset) {
      yield MasterFormResetState();
    }
  }
}
