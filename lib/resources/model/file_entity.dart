import 'package:intl/intl.dart';
import 'package:machine_care/resources/path/app_path.dart';
import 'package:machine_care/resources/path/path.dart';

class FileEntity {
  final String? id;
  String? url;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  FileEntity({this.id, this.url, this.name, this.createdAt, this.updatedAt});

  factory FileEntity.fromJson(Map<String, dynamic> json) {
    return FileEntity(
      id: json["_id"],
      url: "${PathMachine.baseUrl}/${json["url"]}",
      name: json["name"],
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    );
  }

  factory FileEntity.fromJsonHive(Map<dynamic, dynamic> json) {
    return FileEntity(
      id: json["_id"],
      url: "${PathMachine.baseUrl}/${json["url"]}",
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "url": url,
      "name": name,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
  static List<FileEntity> listFromJson(dynamic listJson) =>
      listJson != null ? List<FileEntity>.from(listJson.map((x) => FileEntity.fromJson(x))) : [];
  String get date {
    if (createdAt == null) return "";
    return DateFormat('MM/dd/yyyy').format(createdAt!);
  }

  String get time {
    if (createdAt == null) return "";
    return DateFormat('hh:mm a').format(createdAt!);
  }
}
