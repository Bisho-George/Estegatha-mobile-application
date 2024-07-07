import 'package:hive/hive.dart';
part 'sos_zone.g.dart';

@HiveType(typeId: 0)
class SosZoneEntity {
  @HiveField(0)
  final num id;
  @HiveField(1)
  final double lat;
  @HiveField(2)
  final double lang;
  @HiveField(3)
  final String emergencyType;
  @HiveField(4)
  final double radius;

  SosZoneEntity({
    required this.id,
    required this.lat,
    required this.lang,
    required this.emergencyType,
    required this.radius,
  });
}