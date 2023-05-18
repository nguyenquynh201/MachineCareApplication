import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/enum/gender_enum.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/model/product_entity.dart';

class UserEntity {
  String? sId;
  String? role;
  String? email;
  String? fullName;
  String? phone;
  String? username;
  String? createdAt;
  String? updatedAt;
  String? lastLogin;
  Gender? gender;
  String? avatar;
  String? addressProvince;
  String? addressDistrict;
  String? address;
  String? birthday;
  List<String>? deviceTokens;
  bool? resetPassword;
  List<ProductUserEntity>? listProduct;
  List<UserAddress>? listAddress;

  UserEntity(
      {this.sId,
      this.role,
      this.email,
      this.fullName,
      this.phone,
      this.username,
      this.createdAt,
      this.updatedAt,
      this.lastLogin,
      this.gender,
      this.deviceTokens,
      this.resetPassword,
      this.listAddress,
      this.addressProvince,
      this.addressDistrict,
      this.address,
      this.avatar,
        this.birthday = EndPoint.EMPTY_STRING,
      });

  UserEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String;
    role = json['role'] ?? EndPoint.EMPTY_STRING;
    email = json['email'] ?? EndPoint.EMPTY_STRING;
    fullName = json['fullName'] ?? EndPoint.EMPTY_STRING;
    phone = json['phone'] ?? EndPoint.EMPTY_STRING;
    username = json['username'] ?? EndPoint.EMPTY_STRING;
    createdAt = json['createdAt'] ?? EndPoint.EMPTY_STRING;
    updatedAt = json['updatedAt'] ?? EndPoint.EMPTY_STRING;
    lastLogin = json['lastLogin'] ?? EndPoint.EMPTY_STRING;
    birthday = json['birth'];
    addressProvince = json['addressProvince'] ?? EndPoint.EMPTY_STRING;
    addressDistrict = json['addressDistrict'] ?? EndPoint.EMPTY_STRING;
    address = json['address'] ?? EndPoint.EMPTY_STRING;
    gender = json['gender'] != null ? GenderExtension.valueOf(json['gender']) : null;
    if(json['avatar'] != null) {
      if(json['avatar'].contains('http://') || json['avatar'].contains('https://')) {
        avatar = "${json['avatar']}" ;
      }else {
        avatar = "${EndPoint.baseUrl}/${json['avatar']}";
      }
    }else {
    }
    if (json['deviceTokens'] != null) {
      deviceTokens = <String>[];
      json['deviceTokens'].forEach((v) {
        deviceTokens?.add(v);
      });
    }
    if (json['listProduct'] != null) {
      listProduct = <ProductUserEntity>[];
      json['listProduct'].forEach((v) {
        listProduct?.add(ProductUserEntity.fromJson(v));
      });
    }
    if (json['listAddress'] != null) {
      listAddress = <UserAddress>[];
      json['listAddress'].forEach((v) {
        listAddress?.add(UserAddress.fromJson(v));
      });
    }
    resetPassword = json['resetPassword'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['role'] = role;
    data['email'] = email;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['username'] = username;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['lastLogin'] = lastLogin;
    data['addressProvince'] = addressProvince;
    data['addressDistrict'] = addressDistrict;
    data['address'] = address;
    data['birth'] = birthday.toString();

    data['gender'] = GenderExtension.genderValueOf(gender);
    if (deviceTokens != null) {
      data['deviceTokens'] = deviceTokens?.map((v) => v.toString()).toList();
    }
    data['resetPassword'] = resetPassword;
    data['avatar'] = avatar;
    data['listProduct'] = listProduct?.map((e) => e.toJson()).toList();
    data['listAddress'] = listAddress?.map((e) => e.toJson()).toList();
    return data;
  }

  Map<String, dynamic> toJonUpdate() {
    return {
      'fullName': fullName,
      'phone': phone,
      'gender': GenderExtension.genderValueOf(gender),
      'addressProvince': addressProvince,
      'addressDistrict': addressDistrict,
      'address': address,
      "birth": birthday.toString(),
    };
  }
}

class ProductUserEntity {
  String? sId;
  String? userId;
  ProductEntity? productId;
  String? createdAt;
  String? updatedAt;

  ProductUserEntity({
    this.sId,
    this.userId,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  ProductUserEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    productId = json['productId'] != null ? ProductEntity.fromJson(json['productId']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['userId'] = userId;
    if (productId != null) {
      data['productId'] = productId?.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
