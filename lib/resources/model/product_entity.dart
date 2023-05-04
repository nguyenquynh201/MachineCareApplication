import 'package:machine_care/resources/model/file_entity.dart';

class ProductEntity {
  String? sId;
  String? nameMaintenance;
  String? serialNumber;
  String? manufacturer;
  String? specifications;
  String? yearOfManufacturer;
  bool? show;
  List<FileEntity>? imageMachine;
  String? createdAt;
  String? updatedAt;

  ProductEntity(
      {this.sId,
      this.nameMaintenance,
      this.serialNumber,
      this.manufacturer,
      this.specifications,
      this.yearOfManufacturer,
      this.show,
      this.imageMachine = const [],
      this.createdAt,
      this.updatedAt});

  ProductEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nameMaintenance = json['nameMaintenance'] ?? "";
    serialNumber = json['serialNumber'] ?? "";
    manufacturer = json['manufacturer'] ?? "";
    specifications = json['specifications'] ?? "";
    yearOfManufacturer = json['yearOfManufacturer'] ?? "";
    show = json['show'] ?? false;
    if (json['imageMachine'] != null) {
      imageMachine = <FileEntity>[];
      json['imageMachine'].forEach((v) {
        imageMachine?.add(FileEntity.fromJson(v));
      });
    }
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['nameMaintenance'] = nameMaintenance;
    data['serialNumber'] = serialNumber;
    data['manufacturer'] = manufacturer;
    data['specifications'] = specifications;
    data['yearOfManufacturer'] = yearOfManufacturer;
    data['show'] = show;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
