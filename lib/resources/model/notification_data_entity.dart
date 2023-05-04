class NotificationData {
  String? idComment;
  String? image;
  String? name;
  String? id;
  String? type;

  NotificationData({this.idComment, this.image, this.name, this.id, this.type});

  NotificationData.fromJson(Map<String, dynamic> json) {
    idComment = json['idComment'];
    image = json['image'];
    name = json['name'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idComment'] = idComment;
    data['image'] = image;
    data['name'] = name;
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}