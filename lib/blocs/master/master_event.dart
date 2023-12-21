abstract class MasterEvent {}

class DoctorSelectedEvent extends MasterEvent {
  final Map<String, dynamic> doctorDetails;

  DoctorSelectedEvent(this.doctorDetails);
}

class SaveMasterDataEvent extends MasterEvent {
  final String doctorId;
  final String doctorName;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String pincode;
  final String state;
  final String region;
  final String photoPath; // Path to the uploaded photo

  SaveMasterDataEvent({
    required this.doctorId,
    required this.doctorName,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.pincode,
    required this.state,
    required this.region,
    required this.photoPath,
  });
}
