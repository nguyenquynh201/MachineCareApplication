import 'package:machine_care/ui/ui.dart';

class CommentEntity {
  final String id;
  String? maintenance;
  String? contentComment;
  UserEntity? userId;
  String? userName;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CommentEntity> replys;

  CommentEntity(
      {required this.id,
        this.maintenance,
        this.contentComment,
        this.userId,
        this.userName,
        this.createdAt,
        this.updatedAt,
        this.replys = const []});
  static List<CommentEntity> listFromJson(dynamic listJson) => listJson != null
      ? List<CommentEntity>.from(listJson.map((x) => CommentEntity.fromJson(x)))
      : [];
  factory CommentEntity.fromJson(Map<String, dynamic> json) {
    return CommentEntity(
      id: json['_id'],
      maintenance: json['maintenance'],
      contentComment: json['contentComment'],
      userId: json['userId'] == null
          ? null
          : UserEntity.fromJson(json['userId']),
      replys: List.from(json['replys'] ?? [])
          .map((e) => CommentEntity.fromJson(e))
          .toList(),
      userName: json['userName'],
      createdAt:
      json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt:
      json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    );
  }

  factory CommentEntity.fromJsonReply(Map<String, dynamic> json) {
    return CommentEntity(
      id: json['_id'],
      maintenance: json['maintenance'],
      contentComment: json['contentComment'],
      userId: json['userId'] == null
          ? null
          : UserEntity.fromJson(json['userId']),
      replys: List.from(json['replys'] ?? [])
          .map((e) => CommentEntity.fromJson(e))
          .toList(),
      userName: json['userName'],
      createdAt:
      json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt:
      json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "maintenance": maintenance,
    "contentComment": contentComment,
  };
}
