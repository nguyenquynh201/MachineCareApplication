class ErrorMachineEntity {
  String? sId;
  String? maintenanceContent;
  int? price;

  ErrorMachineEntity({this.sId, this.maintenanceContent, this.price});
  static List<ErrorMachineEntity> listFromJson(dynamic listJson) => listJson != null
      ? List<ErrorMachineEntity>.from(
      listJson.map((x) => ErrorMachineEntity.fromJson(x)))
      : [];
  ErrorMachineEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    maintenanceContent = json['maintenanceContent'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['maintenanceContent'] = maintenanceContent;
    data['price'] = price;
    return data;
  }
}