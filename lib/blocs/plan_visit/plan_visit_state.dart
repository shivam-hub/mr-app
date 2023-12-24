abstract class PlanVisitState {}

class PlanVisitInitialState extends PlanVisitState {}

class DoctorSelectedState extends PlanVisitState {
  final Map<String, dynamic> doctorDetails;

  DoctorSelectedState(this.doctorDetails);
}

class PlanVisitLoadingState extends PlanVisitState {}

class PlanVisitSuccessState extends PlanVisitState {}

class PlanVisitErrorState extends PlanVisitState {
  final String errorMessage;

  PlanVisitErrorState(this.errorMessage);
}
