abstract class MasterEvent {}

class DoctorSelectedEvent extends MasterEvent {
  final Map<String, dynamic> doctorDetails;

  DoctorSelectedEvent(this.doctorDetails);
}

class MasterFormReset extends MasterEvent {
  MasterFormReset();
}

class SaveMasterDataEvent extends MasterEvent {
  final String filePath;
  final Map<String, dynamic> doctorDetails;
  final bool isDoctorSelected;

  SaveMasterDataEvent(
      {required this.filePath,
      required this.doctorDetails,
      this.isDoctorSelected = true});
}
