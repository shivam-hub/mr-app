import 'package:nurene_app/models/prodcut_model.dart';

import 'doctor_model.dart';
import 'location_model.dart';
import 'user_model.dart';

class VisitModel {
  String? mrId;
  String? visitedOn;
  List<Attachment>? attachments;
  Location? location;
  DoctorInfo? doctorInfo;
  UserModel? mrInfo;
  String? feedback;
  List<ProductModel>? products;

  VisitModel(
      {this.mrId,
      this.visitedOn,
      this.attachments,
      this.location,
      this.doctorInfo,
      this.mrInfo,
      this.feedback,
      this.products});

  VisitModel.fromJson(Map<String, dynamic> json) {
    mrId = json['mrId'];
    visitedOn = json['visitedOn'];
    feedback = json['feedback'];
    if (json['attachments'] != null) {
      attachments = <Attachment>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachment.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((p) {
        products!.add(ProductModel.fromJson(p));
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
    data['feedback'] = feedback;
    if (products != null) {
      data['products'] = products!.map((e) => e.toJson()).toList();
    }
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
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
