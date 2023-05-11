import 'package:machine_care/resources/model/model.dart';

class NotificationEntity {
  String? id;
  String? title;
  String? description;
  String? type;
  UserEntity? author;
  bool? isRead;
  Object? object;
  String? relateStaff;
  String? role;
  bool? assign;
  String? createdAt;
  String? updatedAt;

  NotificationEntity(
      {this.id,
        this.title,
        this.description,
        this.type,
        this.author,
        this.isRead,
        this.object,
        this.relateStaff,
        this.role,
        this.assign,
        this.createdAt,
        this.updatedAt,
});
  static List<NotificationEntity> listFromJson(dynamic listJson) => listJson != null
      ? List<NotificationEntity>.from(
      listJson.map((x) => NotificationEntity.fromJson(x)))
      : [];
  NotificationEntity.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    author =
    json['author'] != null ?  UserEntity.fromJson(json['author']) : null;
    isRead = json['isRead'];
    object =
    json['object'] != null ?  Object.fromJson(json['object']) : null;
    relateStaff = json['relateStaff'];
    role = json['role'];
    assign = json['assign'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['isRead'] = isRead;
    if (object != null) {
      data['object'] = object!.toJson();
    }
    data['relateStaff'] = relateStaff;
    data['role'] = role;
    data['assign'] = assign;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Author {
  String? sId;
  String? email;
  String? fullName;
  String? username;
  String? avatar;

  Author({this.sId, this.email, this.fullName, this.username, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    fullName = json['fullName'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['email'] = email;
    data['fullName'] = fullName;
    data['username'] = username;
    data['avatar'] = avatar;
    return data;
  }
}

class Object {
  String? idMaintenance;
  String? target;
  String? startDate;
  String? idStaff;
  String? idUser;
  String? status;

  Object(
      {this.idMaintenance,
        this.target,
        this.startDate,
        this.idStaff,
        this.idUser,
        this.status});

  Object.fromJson(Map<String, dynamic> json) {
    idMaintenance = json['idMaintenance'];
    target = json['target'];
    startDate = json['startDate'];
    idStaff = json['idStaff'];
    idUser = json['idUser'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['idMaintenance'] = idMaintenance;
    data['target'] = target;
    data['startDate'] = startDate;
    data['idStaff'] = idStaff;
    data['status'] = status;
    return data;
  }
}
