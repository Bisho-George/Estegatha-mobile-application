import 'package:estegatha/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/sos_zone_entity.dart';
import '../models/sos_zone_model.dart';

abstract class SosZoneLocalDataSource {
  Future<List<SosZoneEntity>> fetchSosZones();
}

class SosZoneLocalDataSourceImp implements SosZoneLocalDataSource {
  @override
  Future<List<SosZoneEntity>> fetchSosZones() async {
    try {
      var box = await Hive.openBox(kSosZones);
      var result = box.get(kSosZones, defaultValue: []) as List<dynamic>;
      // Convert dynamic list to SosZoneEntity list
      List<SosZoneEntity> sosZones = result.map((item) => SosZoneModel.fromJson(item)).toList();
      return sosZones;
    } catch (e) {
      print("Error fetching SOS zones: $e");
      return []; // Return empty list in case of error or if data doesn't exist
    }
  }
}
