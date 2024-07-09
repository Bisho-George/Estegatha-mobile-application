import 'package:flutter/material.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';

class ProgressIndicatorBar extends StatelessWidget {
  double? percentage;
  String? step;
  ProgressIndicatorBar({super.key, this.percentage, this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
         Text(
          "$step of 4",
          textAlign: TextAlign.end,
          style: const TextStyle(
              color: ConstantColors.textPrimary,
              fontWeight: ConstantSizes.fontWeightSemiBold),
        ),
        const SizedBox(
          height: ConstantSizes.sm,
        ),
        LinearProgressIndicator(
          value: percentage,
          minHeight: 10,
          borderRadius: BorderRadius.circular(50.0),
          backgroundColor: const Color(0xFFF0F0F0),
          color: ConstantColors.primary,
        ),
      ],
    );
  }
}
