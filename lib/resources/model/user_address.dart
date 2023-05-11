import 'dart:ffi';

import '../../ui/ui.dart';

class UserAddress {
  String? id;
  String? userId;
  bool? fixed;
  String? nameAddress;
  Gender? gender;
  String? phone;
  String? addressProvince;
  String? addressDistrict;
  String? addressUser;
  String? createdAt;
  String? updatedAt;

  UserAddress(
      {this.id,
      this.userId,
      this.fixed,
      this.nameAddress,
      this.gender,
      this.phone,
      this.addressProvince,
      this.addressDistrict,
      this.addressUser,
      this.createdAt,
      this.updatedAt});

  static List<UserAddress> listFromJson(dynamic listJson) =>
      listJson != null ? List<UserAddress>.from(listJson.map((x) => UserAddress.fromJson(x))) : [];

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    fixed = json['fixed'];
    nameAddress = json['nameAddress'];
    gender = GenderExtension.valueOf(json['gender']);
    phone = json['phone'];
    addressProvince = json['addressProvince'];
    addressDistrict = json['addressDistrict'];
    addressUser = json['addressUser'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "fixed": fixed,
      "nameAddress": nameAddress,
      "gender": GenderExtension.genderValueOf(gender),
      "phone": phone,
      "addressProvince": addressProvince,
      "addressDistrict": addressDistrict,
      "addressUser": addressUser,
    };
  }
}
