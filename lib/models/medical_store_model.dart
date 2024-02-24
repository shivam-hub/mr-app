// class MedicalStoreModel {
//   String? name;
//   String? location;
//   String? gstNumber;

//   MedicalStoreModel({this.name, this.location, this.gstNumber});

//   MedicalStoreModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     location = json['locaion'];
//     gstNumber = json['gstNumber'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['location'] = location;
//     data['gstNumber'] = gstNumber;
//     return data;
//   }
// }


class MedicalStoreModel {
  String? name;
  String? location;
  String? gstNumber;

  MedicalStoreModel({this.name, this.location, this.gstNumber});

  MedicalStoreModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location']; // corrected typo in the key 'location'
    gstNumber = json['gstNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['location'] = location;
    data['gstNumber'] = gstNumber;
    return data;
  }

  MedicalStoreModel copyWith({
    String? name,
    String? location,
    String? gstNumber,
  }) {
    return MedicalStoreModel(
      name: name ?? this.name,
      location: location ?? this.location,
      gstNumber: gstNumber ?? this.gstNumber,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicalStoreModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          location == other.location &&
          gstNumber == other.gstNumber;

  @override
  int get hashCode => name.hashCode ^ location.hashCode ^ gstNumber.hashCode;
}
