import 'package:Nurene/models/associated_mr_model.dart';
import 'package:Nurene/models/location_model.dart';

import '/models/medical_store_model.dart';

import 'address_info_model.dart';

class DoctorInfo {
  String? drId;
  String? name;
  AddressInfo? addressInfo;
  String? speciality;
  String? clinicName;
  String? doctorRegNumber;
  List<MedicalStoreModel>? associatedMedicals;
  Location? locationCoordinates;
  AssociatedMR? associatedMR;

  DoctorInfo(
      {this.drId,
      this.name,
      this.addressInfo,
      this.speciality,
      this.clinicName,
      this.doctorRegNumber,
      this.associatedMedicals,
      this.associatedMR,
      this.locationCoordinates});

  DoctorInfo.fromJson(Map<String, dynamic> json) {
    drId = json['drId'];
    name = json['name'];
    doctorRegNumber = json['doctorRegNumber'];
    addressInfo = json['addressInfo'] != null
        ? AddressInfo.fromJson(json['addressInfo'])
        : null;
    speciality = json['speciality'];
    clinicName = json['clinicName'];
    associatedMR = json['associatedMR'] != null
        ? AssociatedMR.fromJson(json['associatedMR'])
        : null;
    if (json['associatedMedicals'] != null) {
      associatedMedicals = <MedicalStoreModel>[];
      json['associatedMedicals'].forEach((v) {
        associatedMedicals!.add(MedicalStoreModel.fromJson(v));
      });
    }
    locationCoordinates = json['locationCoordinates'] != null
        ? Location.fromJson(json['locationCoordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['drId'] = drId;
    data['name'] = name;
    if (addressInfo != null) {
      data['addressInfo'] = addressInfo!.toJson();
    }
    data['speciality'] = speciality;
    data['clinicName'] = clinicName;
    data['doctorRegNumber'] = doctorRegNumber;
    if (associatedMedicals != null) {
      data['associatedMedicals'] =
          associatedMedicals!.map((v) => v.toJson()).toList();
    }
    data['locationCoordinates'] = locationCoordinates;
    data['associtatedMR'] = associatedMR;
    if (locationCoordinates != null) {
      data['locationCoordinates'] = locationCoordinates!.toJson();
    }
    return data;
  }
}
