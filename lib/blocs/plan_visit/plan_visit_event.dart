abstract class PlanVisitEvent {}

class DoctorSelectedEvent extends PlanVisitEvent {
  final Map<String, dynamic> doctorDetails;

  DoctorSelectedEvent(this.doctorDetails);
}

class SavePlanVisitDataEvent extends PlanVisitEvent {
  final Map<String, dynamic> doctorDetails;
  final String date;
  final String time;

  SavePlanVisitDataEvent(
      {required this.doctorDetails,
      required this.date,
      required this.time});
}
