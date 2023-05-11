import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/product_entity.dart';
import 'package:machine_care/ui/ui.dart';

class MaintenanceScheduleEntity {
  String? sId;
  String? maintenanceContent;
  ProductEntity? products;
  List<ErrorMachineEntity>? errorMachine;
  TargetMachine? target;
  StatusEnum? status;
  List<BugEntity>? bugs;
  List<UserEntity>? relateStaffs;
  List<RatingEntity>? rating;
  UserAddress? address;
  DateTime? startDate;
  DateTime? dueDate;
  CreateByEntity? createdBy;
  DateTime? createdAt;
  num? totalBugMoney;
  num? totalMoney;
  DateTime? updatedAt;
  String? note;

  MaintenanceScheduleEntity(
      {this.sId,
      this.maintenanceContent,
      this.products,
      this.errorMachine,
      this.target,
      this.status,
      this.bugs,
      this.relateStaffs,
      this.startDate,
      this.dueDate,
      this.createdBy,
      this.totalBugMoney,
      this.createdAt,
      this.updatedAt,
      this.note,
      this.address,
      this.rating});

  static List<MaintenanceScheduleEntity> listFromJson(dynamic listJson) => listJson != null
      ? List<MaintenanceScheduleEntity>.from(
          listJson.map((x) => MaintenanceScheduleEntity.fromJson(x)))
      : [];

  MaintenanceScheduleEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    maintenanceContent = json['maintenanceContent'] ?? EndPoint.EMPTY_STRING;
    products = json['products'] != null ? ProductEntity.fromJson(json['products']) : null;
    if (json['errorMachine'] != []) {
      errorMachine = <ErrorMachineEntity>[];
      json['errorMachine']?.forEach((v) {
        errorMachine?.add(ErrorMachineEntity.fromJson(v));
      });
    }
    target = TargetMachineExtension.valueOf(json['target']);
    status = StatusExtenstion.valueOf(json['status']);
    if (json['bugs'] != null) {
      bugs = <BugEntity>[];
      json['bugs'].forEach((v) {
        bugs!.add(BugEntity.fromJson(v));
      });
    }
    if (json['relateStaffs'] != null) {
      relateStaffs = <UserEntity>[];
      json['relateStaffs'].forEach((v) {
        relateStaffs?.add(UserEntity.fromJson(v));
      });
    }
    if (json['address'] != null) {
      address = UserAddress.fromJson(json['address']);
    }
    if (json['rating'] != null) {
      rating = List.from(json['rating'] ?? []).map((e) => RatingEntity.fromJson(e)).toList();
    }
    startDate = parseDateTime(json['startDate']);
    createdBy = json['createdBy'] != null ? CreateByEntity.fromJson(json['createdBy']) : null;
    dueDate = parseDateTime(json['dueDate']);
    totalBugMoney = json['totalBugMoney'] ?? 0;
    totalMoney = json['totalMoney'] ?? 0;
    note = json['note'];
    createdAt = parseDateTime(json['createdAt']);
    updatedAt = parseDateTime(json['updatedAt']);
  }

  static DateTime? parseDateTime(String? dateTimeString) {
    return (dateTimeString != null) ? DateTime.parse(dateTimeString) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "maintenanceContent": maintenanceContent,
      "note": note,
      "products": products?.sId,
      "address": address?.id,
      "errorMachine": errorMachine?.map((e) => e.sId.toString()).toList(),
      "target": targetValueOf(target),
      "status": StatusExtenstion.statusValueOf(status),
      "bugs": bugs != null ? bugs?.map((v) => v.toJson()).toList() : [],
      "startDate": startDate.toString(),
      "dueDate": startDate.toString(),
    };
  }
  Map<String, dynamic> toJsonUpdate() {
    return {
      "maintenanceContent": maintenanceContent,
      "note": note,
      "address": address?.id,
      "errorMachine": errorMachine?.map((e) => e.sId.toString()).toList(),
      "bugs": (bugs != null || bugs != []) ? bugs?.map((v) => v.toJson()).toList() : [],
      "startDate": startDate.toString(),
      "dueDate": startDate.toString(),
    };
  }

  String targetValueOf(TargetMachine? target) {
    switch (target) {
      case TargetMachine.frequent:
        return TargetMachine.frequent.value;
      case TargetMachine.maintenance:
      default:
        return TargetMachine.maintenance.value;
    }
  }
}

class BugEntity {
  String? nameBug;
  num? priceBug;

  BugEntity({this.nameBug, this.priceBug});

  BugEntity.fromJson(Map<String, dynamic> json) {
    nameBug = json['nameBug'];
    priceBug = json['priceBug'];
  }

  Map<String, dynamic> toJson() {
    return {
      "nameBug": nameBug,
      "priceBug": priceBug,
    };
  }
}
