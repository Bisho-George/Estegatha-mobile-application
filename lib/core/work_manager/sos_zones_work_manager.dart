import 'package:dio/dio.dart';
import 'package:estegatha/features/home/data/data_sources/sos_zone_remote_data_source.dart';
import 'package:estegatha/features/home/data/data_sources/sos_zones_local_data_source.dart';
import 'package:estegatha/utils/services/api_service.dart';
import 'package:workmanager/workmanager.dart';

import '../../features/home/data/repos/sos_zone_repo_imp.dart';

class SosZonesWorkManager {
  static Future<void> scheduleDailyFetch() async {
    await Workmanager().registerPeriodicTask(
      "1",
      "fetchSosZones",
      frequency: const Duration(hours: 24),
      initialDelay: _getInitialDelay(),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static Duration _getInitialDelay() {
    final now = DateTime.now();
    var targetTime = DateTime(now.year, now.month, now.day, 5);
    if (now.isAfter(targetTime)) {
      targetTime = targetTime.add(const Duration(days: 1));
    }
    return targetTime.difference(now);
  }

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      // Call your method to fetch SOS zones
      SosZoneRepoImp repo = SosZoneRepoImp(SosZoneRemoteDataSource(ApiService(Dio())), SosZoneLocalDataSourceImp());
      await repo.fetchSosZones();
      return Future.value(true);
    });
  }
}