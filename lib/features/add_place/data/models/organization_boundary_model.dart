import '../../domain/entities/organization_boundary_entity.dart';

class OrganizationBoundaryModel extends OrganizationBoundaryEntity{
  final num id;
  final String name;
  final double lat;
  final double lang;
  final double radius;

  OrganizationBoundaryModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lang,
    required this.radius
  }) : super(name: name, lat: lat, lang: lang, radius: radius);

  factory OrganizationBoundaryModel.fromJson(Map<String, dynamic> json) {
    return OrganizationBoundaryModel(
      id: json['id'],
      name: json['name'],
      lat: json['lat'],
      lang: json['lang'],
      radius: json['radius'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'lang': lang,
      'radius': radius,
    };
  }
}