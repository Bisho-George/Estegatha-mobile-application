import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class HealthTrackerDataPage extends StatelessWidget {
  const HealthTrackerDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            value: 0.5,
            color: ConstantColors.secondary,
            backgroundColor: ConstantColors.primary,
            strokeWidth: 10,
          ),
        ),
      ),
    );
  }
}
