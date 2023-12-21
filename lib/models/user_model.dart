class UserModel {
  String? username;
  String? password;
  String? userId;
  String? createdOn;
  String? modifiedOn;
  String? contactNo;
  String? email;
  String? name;

  UserModel(
      {this.username,
      this.password,
      this.userId,
      this.createdOn,
      this.modifiedOn,
      this.contactNo,
      this.email,
      this.name});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    userId = json['userId'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    contactNo = json['contactNo'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['userId'] = userId;
    data['createdOn'] = createdOn;
    data['modifiedOn'] = modifiedOn;
    data['contactNo'] = contactNo;
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}