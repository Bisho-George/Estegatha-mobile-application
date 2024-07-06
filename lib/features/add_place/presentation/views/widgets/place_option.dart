
import 'package:flutter/material.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';

class PlaceOption extends StatelessWidget {
  const PlaceOption(
      {super.key,
        required this.optionText,
        required this.icon,
        this.backgroundColor,
        this.borderColor,
        this.iconColor,
        required this.iconSize});

  final String optionText;
  final IconData icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ConstantColors.white,
        border: BorderDirectional(
          bottom: BorderSide(
            color: ConstantColors.grey,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: ConstantSizes.defaultSpace,
          vertical: ConstantSizes.spaceBtwItems),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(50),
              border: borderColor != null
                  ? Border.all(
                color: borderColor ?? ConstantColors.secondaryBackground,
                width: 2,
              )
                  : null,
            ),
            child: CircleAvatar(
                radius: 30,
                backgroundColor:
                backgroundColor ?? ConstantColors.secondaryBackground,
                child: Icon(
                  icon,
                  color: iconColor ?? ConstantColors.white,
                  size: iconSize,
                )),
          ),
          const SizedBox(
            width: ConstantSizes.spaceBtwItems,
          ),
          Text(
            optionText,
            style: const TextStyle(
              color: ConstantColors.primary,
              fontSize: ConstantSizes.fontSizeMd,
              fontWeight: ConstantSizes.fontWeightSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
