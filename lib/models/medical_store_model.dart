class MedicalStoreModel {
  String? name;
  String? location;
  String? gstNumber;

  MedicalStoreModel({this.name, this.location, this.gstNumber});

  MedicalStoreModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['locaion'];
    gstNumber = json['gstNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['location'] = location;
    data['gstNumber'] = gstNumber;
    return data;
  }
}
