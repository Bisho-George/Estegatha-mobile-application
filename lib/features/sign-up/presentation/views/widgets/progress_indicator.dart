import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';

class ProgressIndicatorBar extends StatelessWidget {
  double? percentage;
  String? step;
  String? stepTitle;
  ProgressIndicatorBar({super.key, this.percentage, this.step, this.stepTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (stepTitle != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth * 0.5,
                child: Text(
                  stepTitle!,
                  style: TextStyle(
                      fontSize: SizeConfig.font16,
                      color: ConstantColors.textPrimary,
                      fontWeight: ConstantSizes.fontWeightSemiBold),
                ),
              ),
              Text(
                "$step of 4",
                textAlign: TextAlign.end,
                style: const TextStyle(
                    color: ConstantColors.textPrimary,
                    fontWeight: ConstantSizes.fontWeightSemiBold),
              ),
            ],
          ),
        if (stepTitle == null)
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
