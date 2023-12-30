import 'package:nurene_app/models/medical_store_model.dart';

import 'address_info_model.dart';

class DoctorInfo {
  String? drId;
  String? name;
  AddressInfo? addressInfo;
  String? speciality;
  String? clinicName;
  String? doctorRegNumber;
  List<MedicalStoreModel>? associatedMedicals;

  DoctorInfo(
      {this.drId,
      this.name,
      this.addressInfo,
      this.speciality,
      this.clinicName,
      this.doctorRegNumber,
      this.associatedMedicals});

  DoctorInfo.fromJson(Map<String, dynamic> json) {
    drId = json['drId'];
    name = json['name'];
    doctorRegNumber = json['doctorRegNumber'];
    addressInfo = json['addressInfo'] != null
        ? AddressInfo.fromJson(json['addressInfo'])
        : null;
    speciality = json['speciality'];
    clinicName = json['clinicName'];
    if (json['associatedMedicals'] != null) {
      associatedMedicals = <MedicalStoreModel>[];
      json['associatedMedicals'].forEach((v) {
        associatedMedicals!.add(MedicalStoreModel.fromJson(v));
      });
    }
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
    return data;
  }
}