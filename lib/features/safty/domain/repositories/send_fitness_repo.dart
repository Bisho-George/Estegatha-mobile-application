import '../model/health_metrices_model.dart';

abstract class SendFitnessRepo{
  void sendFitnessData(List<HealthMetricesModel> healthMetrices);
}