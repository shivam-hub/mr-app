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

class MasterSuccessState extends MasterState {}
