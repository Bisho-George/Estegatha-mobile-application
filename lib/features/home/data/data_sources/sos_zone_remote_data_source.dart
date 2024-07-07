import 'package:estegatha/constants.dart';
import 'package:estegatha/features/home/data/data_sources/sos_zone_data_source.dart';
import 'package:hive/hive.dart';

import '../../../../utils/helpers/functions/cache_sos_zones.dart';
import '../../../../utils/services/api_service.dart';
import '../../domain/entities/sos_zone_entity.dart';
import '../models/sos_zone_model.dart';

class SosZoneRemoteDataSource extends SosZoneDataSource {
  final ApiService apiService;

  SosZoneRemoteDataSource(this.apiService);

  @override
  Future<List<SosZoneEntity>> fetchSosZones() async {
      var data = await apiService.get(endpoint: 'sos-zones');
      List<SosZoneEntity> sosZones = getSosZones(data);
      cacheSosZones(sosZones, kSosZones);
      return sosZones;
  }


  List<SosZoneEntity> getSosZones(Map<String, dynamic> data) {
    List<SosZoneEntity> sosZones = [];
    for(var sosZoneMap in data as List){
      sosZones.add(SosZoneModel.fromJson(sosZoneMap));
    }
    return sosZones;
  }
}