import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class TabStatus extends StatelessWidget {
  const TabStatus({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ConstantSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(image),
              color: ConstantColors.iconPrimary,
              size: 80,
            ),
            SizedBox(height: ConstantSizes.md),
            Text(
              title,
              style: TextStyle(
                color: ConstantColors.primary,
                fontSize: ConstantSizes.fontSizeSm,
                fontWeight: ConstantSizes.fontWeightBold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ConstantSizes.sm),
            SizedBox(width: 200, child: subtitle
                // Text(
                //   subtitle,
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: ConstantColors.darkGrey,
                //     fontSize: ConstantSizes.fontSizeSm,
                //   ),
                // ),
                )
          ],
        ),
      ),
    );
  }
}
