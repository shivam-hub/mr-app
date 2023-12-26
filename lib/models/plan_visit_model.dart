import 'doctor_model.dart';

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
