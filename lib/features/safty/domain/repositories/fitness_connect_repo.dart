import 'package:health/health.dart';

abstract class FitnessConnectRepository {
  Future<bool> connect();
  Future<bool> hasPermissions();
}