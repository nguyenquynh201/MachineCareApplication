import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/maintenance_schedule_entity.dart';

import 'model.dart';

class HistoryRepairEntity {
  final String? id;
  final MaintenanceScheduleEntity? before;
  final DateTime? createdAt;
  final UserEntity? updatedBy;
  final String? status;
  HistoryRepairEntity( {
    this.status,
    this.updatedBy,
    this.id,
    this.before,
    this.createdAt,
  });

  static List<HistoryRepairEntity> listFromJson(dynamic listJson) => listJson != null
      ? List<HistoryRepairEntity>.from(listJson.map((x) => HistoryRepairEntity.fromJson(x)))
      : [];

  factory HistoryRepairEntity.fromJson(Map<String, dynamic> json) {
    return HistoryRepairEntity(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["_id"],
        status: json["status"] ?? EndPoint.EMPTY_STRING,
        before: json["before"] != null ? MaintenanceScheduleEntity.fromJson(json["before"]) : null,
        updatedBy: json["updatedBy"] != null ? UserEntity.fromJson(json["updatedBy"]) : null);
  }
}
