import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:nurene_app/models/location_model.dart';
import 'package:nurene_app/models/user_model.dart';
import 'package:nurene_app/services/locator.dart';
import '../../models/doctor_model.dart';
import '/models/visit_model.dart';
import '/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'master_event.dart';
import 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  final ApiService apiService;
  final pref = locator<SharedPreferences>();

  MasterBloc(this.apiService) : super(MasterInitialState());

  @override
  Stream<MasterState> mapEventToState(MasterEvent event) async* {
    if (event is DoctorSelectedEvent) {
      yield DoctorSelectedState(event.doctorDetails);
    } else if (event is SaveMasterDataEvent) {
      try {
        final userDetailsStr = pref.getString('userDetails') ?? '';
        final userDetails = UserModel.fromJson(json.decode(userDetailsStr));
        final visitModel = event.visitModel;
        final longitude = pref.getDouble('longitude') ?? 0;
        final latitude = pref.getDouble('latitude') ?? 0;
        final location = Location();

        visitModel.mrId = userDetails.userId;
        location.type = 'Point';
        location.coordinates = <double>[longitude, latitude];
        visitModel.location = location;
        visitModel.mrInfo = userDetails;
        
        final isSaved =
            await apiService.saveMasterDetails(json.encode(visitModel.toJson()));
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
