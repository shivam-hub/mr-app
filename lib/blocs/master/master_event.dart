import 'package:nurene_app/models/visit_model.dart';

abstract class MasterEvent {}

class DoctorSelectedEvent extends MasterEvent {
  final Map<String, dynamic> doctorDetails;

  DoctorSelectedEvent(this.doctorDetails);
}

class NewDoctorRecordEvent extends MasterEvent {
  final String doctorName;

  NewDoctorRecordEvent(this.doctorName);
}

class MasterFormReset extends MasterEvent {
  MasterFormReset();
}

class SaveMasterDataEvent extends MasterEvent {
  final String filePath;
  final VisitModel visitModel;

  SaveMasterDataEvent({
    required this.filePath,
    required this.visitModel,
  });
}
