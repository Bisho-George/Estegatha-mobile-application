
import 'package:estegatha/features/landing/domain/models/permissions.dart';
import 'package:health/health.dart';

import '../../domain/model/health_metrices_model.dart';
import '../../domain/repositories/fitness_connect_repo.dart';

class FitnessConnectApi extends FitnessConnectRepository {
  final List<HealthDataType> healthTypes = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BLOOD_OXYGEN,
    HealthDataType.BODY_TEMPERATURE
  ];
  final health = HealthFactory();

  @override
  Future<bool> connect() async {
    return await health.requestAuthorization(healthTypes);
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
      DateTime.now().subtract(const Duration(days: 1)),
      DateTime.now(),
      healthTypes,
    );
    Map<HealthDataType, HealthDataPoint> healthMap = {};
    for(var healthPoint in healthData){
      healthMap[healthPoint.type] = healthPoint;
    }
    return [];
  }
}
