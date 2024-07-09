import 'package:dartz/dartz.dart';
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
bool isFineHealth(List<HealthMetricesModel> healthMetrices){
  String ?heartRate = getHealthMetricesValue(HealthDataType.HEART_RATE, healthMetrices);
  String ?bloodOxygen = getHealthMetricesValue(HealthDataType.BLOOD_OXYGEN, healthMetrices);
  String ?bloodPressureSystolic = getHealthMetricesValue(HealthDataType.BLOOD_PRESSURE_SYSTOLIC, healthMetrices);
  String ?bloodPressureDiastolic = getHealthMetricesValue(HealthDataType.BLOOD_PRESSURE_DIASTOLIC, healthMetrices);
  String ?bodyTemperature = getHealthMetricesValue(HealthDataType.BODY_TEMPERATURE, healthMetrices);
  bool status = true;
  if(heartRate != null){
    double value = double.parse(heartRate);
    status = status && value >= 60 && value <= 100;
  }
  if(bloodOxygen != null){
    double value = double.parse(bloodOxygen);
    status = status && value >= 95;
  }
  if(bloodPressureSystolic != null && bloodPressureDiastolic != null){
    double systolic = double.parse(bloodPressureSystolic);
    double diastolic = double.parse(bloodPressureDiastolic);
    status = status && systolic >= 90 && systolic <= 120 && diastolic >= 60 && diastolic <= 80;
  }
  if(bodyTemperature != null){
    double value = double.parse(bodyTemperature);
    status = status && value >= 36.1 && value <= 37.2;
  }
  return status;
}