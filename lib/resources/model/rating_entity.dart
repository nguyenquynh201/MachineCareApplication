class RatingEntity {
  String? id;
  String? maintenanceId;
  String? userId;
  num? rating;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  RatingEntity(
      {this.id,
        this.maintenanceId,
        this.userId,
        this.rating,
        this.comment,
        this.createdAt,
        this.updatedAt});

  RatingEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maintenanceId = json['maintenanceId'];
    userId = json['userId'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = parseDateTime(json['createdAt']);
    updatedAt = parseDateTime(json['updatedAt']);
  }
  static DateTime? parseDateTime(String? dateTimeString) {
    return (dateTimeString != null) ? DateTime.parse(dateTimeString) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['maintenanceId'] = maintenanceId;
    data['userId'] = userId;
    data['rating'] = rating;
    data['comment'] = comment;
    return data;
  }
}
