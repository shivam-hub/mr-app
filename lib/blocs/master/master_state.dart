abstract class MasterState {}

class MasterInitialState extends MasterState {}

class DoctorSelectedState extends MasterState {
  final String doctorName;

  DoctorSelectedState(this.doctorName);
}

class MasterLoadingState extends MasterState {}

class MasterErrorState extends MasterState {
  final String errorMessage;

  MasterErrorState(this.errorMessage);
}

class MasterSuccessState extends MasterState {}
