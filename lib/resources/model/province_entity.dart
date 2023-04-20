class ProvinceEntity {
  String? sId;
  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? phoneCode;

  ProvinceEntity(
      {this.sId, this.name, this.code, this.divisionType, this.codename, this.phoneCode});

  factory ProvinceEntity.fromJson(Map<String, dynamic> json) {
    return ProvinceEntity(
      sId: json['_id'],
      name: json['name'],
      code: json['code'],
      divisionType: json['division_type'],
      codename: json['codename'],
      phoneCode: json['phone_code'],
    );
  }
  static List<ProvinceEntity> listFromJson(dynamic listJson, String search) => listJson != null
      ? List<ProvinceEntity>.from(listJson.map((x) => ProvinceEntity.fromJson(x))).where((element) {
          final nameLower = element.name!.toLowerCase();
          final searchLower = search.toLowerCase();
          return nameLower.contains(searchLower);
        }).toList()
      : [];
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'division_type': divisionType,
      'codename': codename,
      'phone_code': phoneCode
    };
  }
}
