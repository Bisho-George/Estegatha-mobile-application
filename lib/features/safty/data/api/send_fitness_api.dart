import 'package:dio/dio.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/safty/domain/repositories/send_fitness_repo.dart';
import 'package:health/health.dart';

import '../../domain/model/health_metrices_model.dart';

class SendFitnessDataApi extends SendFitnessRepo{
  @override
  void sendFitnessData(List<HealthMetricesModel> healthMetrices) async{
    Dio dio = await DioAuth.getDio();
    dio.post('$baseUrl$sendFitnessEndPoint', data: {
      'bodyTemperature': getHealthMetricesValue(HealthDataType.BODY_TEMPERATURE, healthMetrices)!,
      'heartRate': getHealthMetricesValue(HealthDataType.HEART_RATE, healthMetrices)!,
      'bloodOxygen': getHealthMetricesValue(HealthDataType.BLOOD_OXYGEN, healthMetrices)!,
      'bloodPressureSystolic': getHealthMetricesValue(HealthDataType.BLOOD_PRESSURE_SYSTOLIC, healthMetrices)!,
      'bloodPressureDiastolic': getHealthMetricesValue(HealthDataType.BLOOD_PRESSURE_DIASTOLIC, healthMetrices)!,
      'steps': getHealthMetricesValue(HealthDataType.STEPS, healthMetrices)!,
    });
  }
}