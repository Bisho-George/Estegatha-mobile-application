import 'package:health/health.dart';
class HealthMetricesModel{
  // add thresholds
  final HealthDataType type;
  final String  value;
  HealthMetricesModel({required this.type, required this.value});
}

String ?getHealthMetricesValue(HealthDataType type, List<HealthMetricesModel> healthMetrices){
  for (var element in healthMetrices) {
    if(element.type == type){
      return element.value;
    }
  }
  return null;
}

double ?getHeartRateQuality(List<HealthMetricesModel> healthMetrices){
  for (var element in healthMetrices) {
    if(element.type == HealthDataType.HEART_RATE){
      double value = double.parse(element.value);
      return 100 * (1 - ((value - 70).abs() / 70));
    }
  }
  return null;
}
String ?getBloodPressure(List<HealthMetricesModel> healthMetrices){
  double systolic = -1;
  double diastolic = -1;
  for (var element in healthMetrices) {
    if(element.type == HealthDataType.BLOOD_PRESSURE_SYSTOLIC){
      systolic = double.parse(element.value);
    }
    if(element.type == HealthDataType.BLOOD_PRESSURE_DIASTOLIC){
      diastolic = double.parse(element.value);
    }
  }
  return systolic != -1 && diastolic != -1 ? '$systolic/$diastolic' : null;
}