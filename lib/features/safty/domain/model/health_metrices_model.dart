import 'package:health/health.dart';
class HealthMetricesModel{
  final HealthDataType type;
  final String  value;
  final String unit;
  HealthMetricesModel({required this.type, required this.value, required this.unit});
}