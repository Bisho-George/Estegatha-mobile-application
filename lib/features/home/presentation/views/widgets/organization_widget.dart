import 'package:flutter/material.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';

class OrganizationWidget extends StatelessWidget {
  const OrganizationWidget({super.key});
   @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: ConstantColors.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  'B',
                  style: TextStyle(
                    color: ConstantColors.white,
                    fontSize: ConstantSizes.fontSizeMd,
                    fontWeight: ConstantSizes.fontWeightSemiBold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: ConstantSizes.spaceBtwItems,
            ),
            Text(
              'Family',
              style: TextStyle(
                color: ConstantColors.primary,
                fontSize: ConstantSizes.fontSizeMd,
                fontWeight: ConstantSizes.fontWeightBold,
              ),
            ),
          ],
        ),
        Icon(
          Icons.check,
          color: ConstantColors.primary,
        )
      ],
    );
  }
}
