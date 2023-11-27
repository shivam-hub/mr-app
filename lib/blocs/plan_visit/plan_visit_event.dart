abstract class PlanVisitEvent {}

class DoctorSelectedEvent extends PlanVisitEvent {
  final String selectedDoctor;

  DoctorSelectedEvent(this.selectedDoctor);
}

class SavePlanVisitDataEvent extends PlanVisitEvent {
  // Add necessary fields for saving data
}
