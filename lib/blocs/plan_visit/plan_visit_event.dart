abstract class PlanVisitEvent {}

class DoctorSelectedEvent extends PlanVisitEvent {
  final Map<String, dynamic> doctorDetails;

  DoctorSelectedEvent(this.doctorDetails);
}

class SavePlanVisitDataEvent extends PlanVisitEvent {
  final String doctorName;
  final String addressLine1;
  final String city;
  final String pincode;
  final String state;
  final String region;
  final String date;
  final String time;

  SavePlanVisitDataEvent(
      {required this.doctorName,
      required this.addressLine1,
      required this.city,
      required this.pincode,
      required this.state,
      required this.region,
      required this.date,
      required this.time});
}
