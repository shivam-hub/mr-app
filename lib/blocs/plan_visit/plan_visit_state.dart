import 'package:nurene_app/models/user_model.dart';

abstract class PlanVisitState {}

class PlanVisitInitialState extends PlanVisitState {}

class DoctorSelectedState extends PlanVisitState {
  final Map<String, dynamic> doctorDetails;

  DoctorSelectedState(this.doctorDetails);
}

class PlanVisitLoadingState extends PlanVisitState {}

class PlanVisitSuccessState extends PlanVisitState {
  final bool isSuccess;
  final UserModel userModel;
  PlanVisitSuccessState(this.isSuccess, this.userModel);
}

class PlanVisitErrorState extends PlanVisitState {
  final String errorMessage;

  PlanVisitErrorState(this.errorMessage);
}
