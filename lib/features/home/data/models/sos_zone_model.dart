import '../../domain/entities/sos_zone_entity.dart';

class SosZoneModel extends SosZoneEntity {
  final num id;
  final double lat;
  final double lang;
  final String emergencyType;
  final double radius;

  SosZoneModel({
    required this.id,
    required this.lat,
    required this.lang,
    required this.emergencyType,
    required this.radius,
  }) : super(id: id, lat: lat, lang: lang, emergencyType: emergencyType, radius: radius);

  factory SosZoneModel.fromJson(Map<String, dynamic> json) {
    return SosZoneModel(
      id: json['id'],
      lat: json['lat'],
      lang: json['lang'],
      emergencyType: json['emergencyType'],
      radius: json['radius'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'lang': lang,
      'emergencyType': emergencyType,
      'radius': radius,
    };
  }
}