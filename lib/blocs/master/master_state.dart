import '/models/user_model.dart';

abstract class MasterState {}

class MasterInitialState extends MasterState {}

class DoctorSelectedState extends MasterState {
  final Map<String, dynamic> doctorDetails;
  String? scheduleId;
  DoctorSelectedState({required this.doctorDetails, this.scheduleId = ''});
}

class MasterLoadingState extends MasterState {}

class MasterErrorState extends MasterState {
  final String errorMessage;

  MasterErrorState(this.errorMessage);
}

class NewDoctorRecordState extends MasterState {}

class PlanRecordState extends MasterState {
  final Map<String, dynamic> doctorDetails;
  final String scheduleId;
  PlanRecordState(this.doctorDetails, this.scheduleId);
}

class MasterFormResetState extends MasterState {}

class MasterSuccessState extends MasterState {
  final bool isSuccess;
  final UserModel userModel;

  MasterSuccessState(this.isSuccess, this.userModel);
}
