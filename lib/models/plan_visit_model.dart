import 'package:nurene_app/models/MedicalStoreModel.dart';

class PlanVisitModel {
  DoctorInfo? doctorInfo;
  String? plannedVisitDate;
  String? plannedVisitTime;
  String? priority;
  bool? isVisited;
  String? scheduleId;
  String? mrId;

  PlanVisitModel(
      {this.doctorInfo,
      this.plannedVisitDate,
      this.plannedVisitTime,
      this.priority,
      this.isVisited,
      this.scheduleId,
      this.mrId});

  PlanVisitModel.fromJson(Map<String, dynamic> json) {
    doctorInfo = json['doctorInfo'] != null
        ? DoctorInfo.fromJson(json['doctorInfo'])
        : null;
    plannedVisitDate = json['plannedVisitDate'];
    plannedVisitTime = json['plannedVisitTime'];
    priority = json['priority'];
    isVisited = json['isVisited'];
    scheduleId = json['scheduleId'];
    mrId = json['mrId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doctorInfo != null) {
      data['doctorInfo'] = doctorInfo!.toJson();
    }
    data['plannedVisitDate'] = plannedVisitDate;
    data['plannedVisitTime'] = plannedVisitTime;
    data['priority'] = priority;
    data['isVisited'] = isVisited;
    data['scheduleId'] = scheduleId;
    data['mrId'] = mrId;
    return data;
  }
}

class DoctorInfo {
  String? drId;
  String? name;
  AddressInfo? addressInfo;
  String? speciality;
  String? clinicName;
  List<MedicalStoreModel>? associatedMedicals;

  DoctorInfo(
      {this.drId,
      this.name,
      this.addressInfo,
      this.speciality,
      this.clinicName,
      this.associatedMedicals});

  DoctorInfo.fromJson(Map<String, dynamic> json) {
    drId = json['drId'];
    name = json['name'];
    addressInfo = json['addressInfo'] != null
        ? AddressInfo.fromJson(json['addressInfo'])
        : null;
    speciality = json['speciality'];
    clinicName = json['clinicName'];
    if (json['associatedMedicals'] != null) {
      associatedMedicals = <MedicalStoreModel>[];
      json['associatedMedicals'].forEach((   v) {
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
    if (associatedMedicals != null) {
      data['associatedMedicals'] =
          associatedMedicals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressInfo {
  String? addressline1;
  String? addressline2;
  String? city;
  String? region;
  String? state;
  String? pincode;

  AddressInfo(
      {this.addressline1,
      this.addressline2,
      this.city,
      this.region,
      this.state,
      this.pincode});

  AddressInfo.fromJson(Map<String, dynamic> json) {
    addressline1 = json['addressline1'];
    addressline2 = json['addressline2'];
    city = json['city'];
    region = json['region'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressline1'] = addressline1;
    data['addressline2'] = addressline2;
    data['city'] = city;
    data['region'] = region;
    data['state'] = state;
    data['pincode'] = pincode;
    return data;
  }
}

class AssociatedMedicals {
  String? name;
  AddressInfo? addressInfo;

  AssociatedMedicals({this.name, this.addressInfo});

  AssociatedMedicals.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    addressInfo = json['addressInfo'] != null
        ? AddressInfo.fromJson(json['addressInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (addressInfo != null) {
      data['addressInfo'] = addressInfo!.toJson();
    }
    return data;
  }
}
