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
  int? iV;
  String? lastLogin;
  String? gender;
  List<String>? deviceTokens;
  bool? resetPassword;
  List<ProductUserEntity>? listProduct;
  List<UserAddress>? listAddress;

  UserEntity({
    this.sId,
    this.role,
    this.email,
    this.fullName,
    this.phone,
    this.username,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.lastLogin,
    this.gender,
    this.deviceTokens,
    this.resetPassword,
    this.listAddress
  });

  UserEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String;
    role = json['role'] as String;
    email = json['email'] as String;
    fullName = json['fullName'] as String;
    phone = json['phone'] as String;
    username = json['username'] as String;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lastLogin = json['lastLogin'];
    gender = json['gender'];
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
    data['gender'] = gender;
    if (deviceTokens != null) {
      data['deviceTokens'] = deviceTokens?.map((v) => v.toString()).toList();
    }
    data['resetPassword'] = resetPassword;
    data['listProduct'] = listProduct?.map((e) => e.toJson()).toList();
    data['listAddress'] = listAddress?.map((e) => e.toJson()).toList();
    return data;
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
