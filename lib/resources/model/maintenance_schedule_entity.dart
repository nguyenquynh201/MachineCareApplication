import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/product_entity.dart';
import 'package:machine_care/ui/ui.dart';

class MaintenanceScheduleEntity {
  String? sId;
  String? maintenanceContent;
  ProductEntity? products;
  List<ErrorMachineEntity> errorMachine;
  TargetMachine? target;
  StatusEnum? status;
  List<BugEntity> bugs;
  List<UserEntity> relateStaffs;
  List<RatingEntity> rating;
  UserAddress? address;
  DateTime? startDate;
  DateTime? dueDate;
  CreateByEntity? createdBy;
  DateTime? createdAt;
  num? totalBugMoney;
  num? totalMoney;
  DateTime? updatedAt;
  String? note;
  List<CommentEntity> comments;

  MaintenanceScheduleEntity(
      {this.sId,
      this.maintenanceContent,
      this.products,
      this.errorMachine = const [],
      this.target,
      this.status,
      this.bugs = const [],
      this.relateStaffs = const [],
      this.startDate,
      this.dueDate,
      this.createdBy,
      this.totalBugMoney,
      this.createdAt,
      this.updatedAt,
      this.note,
      this.address,
      this.totalMoney,
      this.comments = const [],
      this.rating = const []});

  static List<MaintenanceScheduleEntity> listFromJson(dynamic listJson) => listJson != null
      ? List<MaintenanceScheduleEntity>.from(
          listJson.map((x) => MaintenanceScheduleEntity.fromJson(x)))
      : [];

  factory MaintenanceScheduleEntity.fromJson(Map<String, dynamic> json) {
    return MaintenanceScheduleEntity(
      sId: json['_id'],
      maintenanceContent: json['maintenanceContent'] ?? EndPoint.EMPTY_STRING,
      products: json['products'] != null ? ProductEntity.fromJson(json['products']) : null,
      errorMachine: List.from(json['errorMachine'] ?? [])
          .map((e) => ErrorMachineEntity.fromJson(e))
          .toList(),
      target: TargetMachineExtension.valueOf(json['target']),
      status: StatusExtenstion.valueOf(json['status']),
      bugs: List.from(json['bugs'] ?? []).map((e) => BugEntity.fromJson(e)).toList(),
      relateStaffs: List.from(json['relateStaffs'] ?? [])
          .map((e) => UserEntity.fromJson(e))
          .toList(),
      address: json['address'] != null ? UserAddress.fromJson(json['address']) : null,
      rating: List.from(json['rating'] ?? []).map((e) => RatingEntity.fromJson(e)).toList(),
      startDate: parseDateTime(json['startDate']),
      createdBy: json['createdBy'] != null ? CreateByEntity.fromJson(json['createdBy']) : null,
      dueDate: parseDateTime(json['dueDate']),
      totalBugMoney: json['totalBugMoney'] ?? 0,
      totalMoney: json['totalMoney'] ?? 0,
      note: json['note'],
      createdAt: parseDateTime(json['createdAt']),
      updatedAt: parseDateTime(json['updatedAt']),
    );
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
      "errorMachine": errorMachine.map((e) => e.sId.toString()).toList(),
      "target": targetValueOf(target),
      "status": StatusExtenstion.statusValueOf(status),
      "bugs": bugs.isNotEmpty ? bugs.map((v) => v.toJson()).toList() : [],
      "startDate": startDate.toString(),
      "dueDate": startDate.toString(),
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "maintenanceContent": maintenanceContent,
      "note": note,
      "address": address?.id,
      "errorMachine": errorMachine.map((e) => e.sId.toString()).toList(),
      "bugs": bugs.isNotEmpty ? bugs.map((v) => v.toJson()).toList() : [],
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
