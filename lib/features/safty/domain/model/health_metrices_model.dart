import 'package:health/health.dart';
class HealthMetricesModel{
  final List<HealthValue> values = [];
  final HealthDataType type;
  final String  value;
  final String unit;
  HealthMetricesModel({required this.type, required this.value, required this.unit});
}
