class VisitModel {
  String? mrId;
  String? visitedOn;
  List<Attachment>? attachment;
  Location? location;
  DoctorInfo? doctorInfo;
  MrInfo? mrInfo;

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
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    doctorInfo = json['doctorInfo'] != null
        ? DoctorInfo.fromJson(json['doctorInfo'])
        : null;
    mrInfo =
        json['mrInfo'] != null ? MrInfo.fromJson(json['mrInfo']) : null;
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

class Location {
  String? type;
  List<int>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class DoctorInfo {
  String? drId;
  String? name;
  AddressInfo? addressInfo;
  String? speciality;
  String? clinicName;
  List<AssociatedMedicals>? associatedMedicals;

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
      associatedMedicals = <AssociatedMedicals>[];
      json['associatedMedicals'].forEach((v) {
        associatedMedicals!.add(AssociatedMedicals.fromJson(v));
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

class MrInfo {
  String? username;
  String? contactno;
  String? email;
  String? userId;
  String? name;

  MrInfo({this.username, this.contactno, this.email, this.userId, this.name});

  MrInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    contactno = json['contactno'];
    email = json['email'];
    userId = json['userId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['contactno'] = contactno;
    data['email'] = email;
    data['userId'] = userId;
    data['name'] = name;
    return data;
  }
}
