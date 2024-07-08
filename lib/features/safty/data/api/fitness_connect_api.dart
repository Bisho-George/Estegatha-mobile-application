import 'package:estegatha/core/work_manager/work_manager.dart';
import 'package:estegatha/features/landing/domain/models/permissions.dart';
import 'package:estegatha/features/safty/data/api/send_fitness_api.dart';
import 'package:health/health.dart';

import '../../domain/model/health_metrices_model.dart';
import '../../domain/repositories/fitness_connect_repo.dart';

class FitnessConnectApi extends FitnessConnectRepository {
  final List<HealthDataType> healthTypes = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BLOOD_OXYGEN,
    HealthDataType.BODY_TEMPERATURE,
  ];
  final health = HealthFactory();

  @override
  Future<bool> connect() async {
    bool res = await health.requestAuthorization(healthTypes);
    return res;
  }

  @override
  Future<bool> hasPermissions() async {
    bool? hasPermissions = await health.hasPermissions(healthTypes);
    return hasPermissions != null && hasPermissions;
  }

  @override
  Future<void> changeAccount() async {
    await health.revokePermissions();
    await Permissions().grantPermissions();
    await health.requestAuthorization(healthTypes);
  }

  @override
  Future<List<HealthMetricesModel>> fetchData() async {
    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      DateTime.now().subtract(const Duration(days: 8)),
      DateTime.now(),
      healthTypes,
    );
    Map<HealthDataType, List<HealthDataPoint>> healthMap = {};
    for (var healthPoint in healthData) {
      if (healthMap[healthPoint.type] == null) {
        healthMap[healthPoint.type] = [];
      }
      healthMap[healthPoint.type]!.add(healthPoint);
    }
    return dumpData(healthMap);
  }

  List<HealthMetricesModel> dumpData(Map<HealthDataType, List<HealthDataPoint>> healthMap) {
    List<HealthMetricesModel> healthMetrices = [];
    for (var record in healthMap.entries) {
      record.value.sort((a, b) => a.dateFrom.compareTo(b.dateTo));
      if (record.key == HealthDataType.STEPS) {
        double sum = 0;
        for (var healthPoint in record.value) {
          if(healthPoint.dateFrom.isBefore(DateTime.now().subtract(const Duration(hours: 1)))){
            continue;
          }
          sum += double.parse(healthPoint.value.toString());
        }
        healthMetrices.add(
          HealthMetricesModel(
            type: record.key,
            value: sum.toString(),
          ),
        );
      } else {
        healthMetrices.add(
          HealthMetricesModel(
            type: record.key,
            value: double.parse(record.value.last.value.toString()).toStringAsFixed(2),
          ),
        );
      }
    }
    return healthMetrices;
  }
}
