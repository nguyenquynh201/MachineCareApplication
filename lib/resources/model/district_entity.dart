class DistrictEntity {
  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? provinceCode;

  DistrictEntity({
    this.name,
    this.code,
    this.divisionType,
    this.codename,
    this.provinceCode,
  });

  factory DistrictEntity.fromJson(Map<String, dynamic> json) {
    return DistrictEntity(
        name: json['name'],
        code: json['code'],
        divisionType: json['division_type'],
        codename: json['codename'],
        provinceCode: json['province_code']);
  }
  static List<DistrictEntity> listFromJson(dynamic listJson, String search) => listJson != null
      ? List<DistrictEntity>.from(listJson.map((x) => DistrictEntity.fromJson(x))).where((element) {
    final nameLower = element.name!.toLowerCase();
    final searchLower = search.toLowerCase();
    return nameLower.contains(searchLower);
  }).toList()
      : [];
}
