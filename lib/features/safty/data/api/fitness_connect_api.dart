import 'package:flutter/services.dart';
import 'package:health/health.dart';

import '../../domain/repositories/fitness_connect_repo.dart';

class FitnessConnectApi extends FitnessConnectRepository {
  final List<HealthDataType> healthTypes = [
    HealthDataType.STEPS,
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.BODY_MASS_INDEX,
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.BLOOD_OXYGEN,
    HealthDataType.BODY_TEMPERATURE];
  final health = HealthFactory();
  @override
  Future<bool> connect() async {
    return await health.requestAuthorization(healthTypes);
  }

  @override
  Future<bool> hasPermissions() async{
    return await health.hasPermissions(healthTypes) ?? false;
  }
}
