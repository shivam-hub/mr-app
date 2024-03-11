class AssociatedMR {
  String? id;
  String? name;

  AssociatedMR({this.id, this.name});

  AssociatedMR.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
