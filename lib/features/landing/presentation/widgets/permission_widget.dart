import 'package:estegatha/features/landing/domain/models/permissions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/image_strings.dart';
import '../../../../utils/constant/sizes.dart';

class PermissionWidget extends StatelessWidget {
  PermissionWidget({super.key, required this.permission});
  PermissionDescription permission;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          permission.name,
          style: Styles.getDefaultPrimary(
              weight: ConstantSizes.fontWeightBold
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:4.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250.0,
                child: Text(
                  permission.description,
                  style: Styles.getDefaultSecondary(
                    fontSize: ConstantSizes.fontSizeSm,
                  ),
                ),
              ),
              Image.asset(
                ConstantImages.onBoardingImage3,
                width: 24.0,
                height: 24.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
