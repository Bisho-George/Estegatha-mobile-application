import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';

class OrganizationOption extends StatelessWidget {
  const OrganizationOption({
    super.key,
    required this.optionName,
    required this.iconPath,
  });

  final String optionName;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ConstantColors.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: SvgPicture.asset(
            iconPath,
            color: ConstantColors.primary,
          ),
        ),
        SizedBox(width: ConstantSizes.spaceBtwItems),
        Text(optionName,
            style: TextStyle(
              color: ConstantColors.primary,
              fontSize: ConstantSizes.fontSizeMd,
              fontWeight: ConstantSizes.fontWeightBold,
            ))
      ],
    );
  }
}
