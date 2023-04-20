import 'package:machine_care/resources/model/file_entity.dart';

class BannerEntity {
  String? sId;
  List<BannerLanguage>? bannerLanguage;
  String? link;
  String? bannerType;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<FileEntity>? image;

  BannerEntity(
      {this.sId,
        this.bannerLanguage,
        this.link,
        this.bannerType,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.image});

  BannerEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['bannerLanguage'] != null) {
      bannerLanguage = <BannerLanguage>[];
      json['bannerLanguage'].forEach((v) {
        bannerLanguage?.add(BannerLanguage.fromJson(v));
      });
    }
    link = json['link'];
    bannerType = json['bannerType'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['image'] != null) {
      image = <FileEntity>[];
      json['image'].forEach((v) {
        image?.add(FileEntity.fromJson(v));
      });
    }  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    if (bannerLanguage != null) {
      data['bannerLanguage'] =
          bannerLanguage!.map((v) => v.toJson()).toList();
    }
    data['link'] = link;
    data['bannerType'] = bannerType;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
  static List<BannerEntity> listFromJson(dynamic listJson) =>
      listJson != null ? List<BannerEntity>.from(listJson.map((x) => BannerEntity.fromJson(x))) : [];
}

class BannerLanguage {
  String? title;
  String? description;
  String? codeLanguage;

  BannerLanguage({this.title, this.description, this.codeLanguage});

  BannerLanguage.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    codeLanguage = json['codeLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['codeLanguage'] = codeLanguage;
    return data;
  }
}