class StatusEntity {
  final String id;
  String name;
  String? description;
  String color;
  bool? inactiveProduct;
  DateTime? createdAt;
  DateTime? updatedAt;

  StatusEntity(
      {required this.id,
        required this.name,
        this.description,
        required this.color,
        this.inactiveProduct = true,
        this.createdAt,
        this.updatedAt});
  static List<StatusEntity> listFromJson(dynamic listJson) => listJson != null
      ? List<StatusEntity>.from(
      listJson.map((x) => StatusEntity.fromJson(x)))
      : [];

  factory StatusEntity.fromJson(Map<String, dynamic> json) {
    return StatusEntity(
      id: json["_id"],
      name: json["name"],
      description: json["description"] ?? "",
      color: json["color"],
      createdAt:
      json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt:
      json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "color": color,
    "inactiveProduct": inactiveProduct,
  };
}
