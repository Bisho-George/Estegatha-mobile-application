import 'package:estegatha/features/safty/domain/model/health_metrices_model.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';

import 'health_metrices_widget.dart';
import 'heart_rate_widget.dart';

class HealthDataWidget extends StatelessWidget {
  HealthDataWidget({super.key, this.healthMetrices = const []});

  List<HealthMetricesModel> healthMetrices;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HeartRateWidget(
                heartRate: getHealthMetricesValue(
                        HealthDataType.HEART_RATE, healthMetrices) ??
                    'N/A',
                quality: getHeartRateQuality(healthMetrices) ?? -1,
              ),
              HealthMetricesWidget(
                type: 'Blood Pressure',
                value: getBloodPressure(healthMetrices) ?? 'N/A',
                unit: 'mm Hg',
              ),
              HealthMetricesWidget(
                type: 'Blood Oxygen',
                value: getHealthMetricesValue(
                        HealthDataType.BLOOD_OXYGEN, healthMetrices) ??
                    'N/A',
                unit: '%',
              ),
              HealthMetricesWidget(
                type: 'Temperature',
                value: getHealthMetricesValue(
                        HealthDataType.BODY_TEMPERATURE, healthMetrices) ??
                    'N/A',
                unit: '°C',
              ),
              HealthMetricesWidget(
                type: 'Steps',
                value: getHealthMetricesValue(
                        HealthDataType.STEPS, healthMetrices) ??
                    'N/A',
                unit: 'the last hours',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
