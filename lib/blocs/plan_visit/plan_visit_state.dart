abstract class PlanVisitState {}

class PlanVisitInitialState extends PlanVisitState {}

class PlanVisitLoadingState extends PlanVisitState {}

class PlanVisitSuccessState extends PlanVisitState {}

class PlanVisitErrorState extends PlanVisitState {
  final String errorMessage;

  PlanVisitErrorState(this.errorMessage);
}
