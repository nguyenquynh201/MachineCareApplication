class CreateByEntity {
  String? sId;
  String? role;
  String? fullName;
  String? phone;
  String? username;

  CreateByEntity(
      {this.sId, this.role, this.fullName, this.phone, this.username});

  CreateByEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    fullName = json['fullName'];
    phone = json['phone'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['role'] = role;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['username'] = username;
    return data;
  }
}