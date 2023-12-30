import 'package:nurene_app/models/user_model.dart';

abstract class MasterState {}

class MasterInitialState extends MasterState {}

class DoctorSelectedState extends MasterState {
  final Map<String, dynamic> doctorDetails;

  DoctorSelectedState(this.doctorDetails);
}

class MasterLoadingState extends MasterState {}

class MasterErrorState extends MasterState {
  final String errorMessage;

  MasterErrorState(this.errorMessage);
}

class NewDoctorRecordState extends MasterState {}

class MasterFormResetState extends MasterState {}

class MasterSuccessState extends MasterState {
  final bool isSuccess;
  final UserModel userModel;

  MasterSuccessState(this.isSuccess, this.userModel);
}
