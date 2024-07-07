import 'package:dartz/dartz.dart';
import 'package:estegatha/features/home/domain/entities/sos_zone_entity.dart';

import '../../../../utils/helpers/failure.dart';

abstract class SosZoneDataSource {
  Future<List<SosZoneEntity>> fetchSosZones();
}