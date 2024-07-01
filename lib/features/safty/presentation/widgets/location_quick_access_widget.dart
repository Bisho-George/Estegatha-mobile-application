import 'package:flutter/material.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';
class LocationQuickAccessWidget extends StatelessWidget {
  LocationQuickAccessWidget({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap
  });
  String title;
  String iconPath;
  void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(ConstantSizes.xl),
          vertical: responsiveHeight(ConstantSizes.lg),
        ),
        decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ConstantColors.buttonDisabled,
                width: 1,
              ),
            )
        ),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(iconPath),
              color: ConstantColors.primary,
              size: 24,
            ),
            SizedBox(
              width: responsiveWidth(ConstantSizes.sm),
            ),
            Text(
              title,
              style: Styles.getDefaultPrimary(
                weight: ConstantSizes.fontWeightSemiBold,
                fontSize: ConstantSizes.fontSizeLg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}