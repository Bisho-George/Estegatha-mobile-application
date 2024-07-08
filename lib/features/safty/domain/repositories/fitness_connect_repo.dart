import 'package:health/health.dart';

import '../model/health_metrices_model.dart';

abstract class FitnessConnectRepository {
  Future<bool> connect();
  Future<bool> hasPermissions();
  Future<void> changeAccount();
  Future<List<HealthMetricesModel>> fetchData();
}