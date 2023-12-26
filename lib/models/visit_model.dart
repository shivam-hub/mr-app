import 'doctor_model.dart';
import 'location_model.dart';
import 'user_model.dart';

class VisitModel {
  String? mrId;
  String? visitedOn;
  List<Attachment>? attachment;
  Location? location;
  DoctorInfo? doctorInfo;
  UserModel? mrInfo;

  VisitModel(
      {this.mrId,
      this.visitedOn,
      this.attachment,
      this.location,
      this.doctorInfo,
      this.mrInfo});

  VisitModel.fromJson(Map<String, dynamic> json) {
    mrId = json['mrId'];
    visitedOn = json['visitedOn'];
    if (json['attachment'] != null) {
      attachment = <Attachment>[];
      json['attachment'].forEach((v) {
        attachment!.add(Attachment.fromJson(v));
      });
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    doctorInfo = json['doctorInfo'] != null
        ? DoctorInfo.fromJson(json['doctorInfo'])
        : null;
    mrInfo = json['mrInfo'] != null ? UserModel.fromJson(json['mrInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mrId'] = mrId;
    data['visitedOn'] = visitedOn;
    if (attachment != null) {
      data['attachment'] = attachment!.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (doctorInfo != null) {
      data['doctorInfo'] = doctorInfo!.toJson();
    }
    if (mrInfo != null) {
      data['mrInfo'] = mrInfo!.toJson();
    }
    return data;
  }
}

class Attachment {
  String? fileName;
  String? fileId;

  Attachment({this.fileName, this.fileId});

  Attachment.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    fileId = json['fileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileName'] = fileName;
    data['fileId'] = fileId;
    return data;
  }
}
