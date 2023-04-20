import 'package:machine_care/enum/target.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/model/product_entity.dart';

class MaintenanceScheduleEntity {
  String? sId;
  String? maintenanceContent;
  ProductEntity? products;
  List<ErrorMachineEntity>? errorMachine;
  TargetMachine? target;
  StatusEntity? status;
  List<BugEntity>? bugs;
  List<UserEntity>? relateStaffs;
  DateTime? startDate;
  CreateByEntity? createdBy;
  int? totalBugMoney;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? note;

  MaintenanceScheduleEntity({
    this.sId,
    this.maintenanceContent,
    this.products,
    this.errorMachine,
    this.target,
    this.status,
    this.bugs,
    this.relateStaffs,
    this.startDate,
    this.createdBy,
    this.totalBugMoney,
    this.createdAt,
    this.updatedAt,
    this.note
  });
  static List<MaintenanceScheduleEntity> listFromJson(dynamic listJson) => listJson != null
      ? List<MaintenanceScheduleEntity>.from(
          listJson.map((x) => MaintenanceScheduleEntity.fromJson(x)))
      : [];
  MaintenanceScheduleEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    maintenanceContent = json['maintenanceContent'];
    products = json['products'] != null ? ProductEntity.fromJson(json['products']) : null;
    if (json['errorMachine'] != []) {
      errorMachine = <ErrorMachineEntity>[];
      json['errorMachine']?.forEach((v) {
        errorMachine?.add(ErrorMachineEntity.fromJson(v));
      });
    }
    target = TargetMachineExtension.valueOf(json['target']);
    status = json['status'] != null ? StatusEntity.fromJson(json['status']) : null;
    if (json['bugs'] != null) {
      bugs = <BugEntity>[];
      json['bugs'].forEach((v) {
        bugs!.add(BugEntity.fromJson(v));
      });
    }
    if (json['relateStaffs'] != null) {
      relateStaffs = <UserEntity>[];
      json['relateStaffs'].forEach((v) {
        relateStaffs!.add(UserEntity.fromJson(v));
      });
    }
    startDate = parseDateTime(json['startDate']);
    createdBy = json['createdBy'] != null ? CreateByEntity.fromJson(json['createdBy']) : null;
    totalBugMoney = json['totalBugMoney'];
    note = json['note'];
    createdAt = parseDateTime(json['createdAt']);
    updatedAt = parseDateTime(json['updatedAt']);
  }
  static DateTime? parseDateTime(String? dateTimeString) {
    return (dateTimeString != null) ? DateTime.parse(dateTimeString) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
      data['maintenanceContent'] = maintenanceContent;
      data['note'] = note;
    if (products != null) {
      data['products'] = products?.sId;
    }
    if (errorMachine != null) {
      data['errorMachine'] = errorMachine?.map((e) => e.sId).toList();
    }
    data['target'] = targetValueOf(target);
    if (status != null) {
      data['status'] = status?.id;
    }
    if (bugs != null) {
      data['bugs'] = bugs?.map((v) => v.toJson()).toList();
    }
    if (relateStaffs != null) {
      data['relateStaffs'] = relateStaffs?.map((v) => v.toJson()).toList();
    }
    data['startDate'] = startDate.toString();
    return data;
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
