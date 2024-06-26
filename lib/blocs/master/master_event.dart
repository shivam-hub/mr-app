
import '../../models/visit_model.dart';

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

class MasterInitialEvent extends MasterEvent {}

class PlanRecordEvent extends MasterEvent {
  final String doctorId;
  final String scheduleId;

  PlanRecordEvent(this.doctorId, this.scheduleId);
}

class SaveMasterDataEvent extends MasterEvent {
  final VisitModel visitModel;
  final String? filePath;

  SaveMasterDataEvent({
    required this.visitModel,
    this.filePath,
  });
}
