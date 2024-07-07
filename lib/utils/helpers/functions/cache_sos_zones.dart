
import 'package:hive/hive.dart';

import '../../../features/home/domain/entities/sos_zone_entity.dart';

void cacheSosZones(List<SosZoneEntity> sosZones, String boxName) {
  var box = Hive.box(boxName);
  box.addAll(sosZones);
}
