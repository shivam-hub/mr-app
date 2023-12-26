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