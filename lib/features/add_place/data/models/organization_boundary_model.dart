class OrganizationBoundaryModel {
  final num id;
  final String name;
  final double lat;
  final double lang;

  OrganizationBoundaryModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lang,
  });

  factory OrganizationBoundaryModel.fromJson(Map<String, dynamic> json) {
    return OrganizationBoundaryModel(
      id: json['id'],
      name: json['name'],
      lat: json['lat'],
      lang: json['lang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'lang': lang,
    };
  }
}