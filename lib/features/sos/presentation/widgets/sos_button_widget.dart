import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';


import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/colors.dart';
class SosButtonWidget extends StatelessWidget {
  SosButtonWidget({
    super.key,
    required this.onTap
  });
  void Function () onTap;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: responsiveHeight(80) + responsiveWidth(35) ,
      backgroundColor: ConstantColors.borderSecondary,
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: responsiveHeight(70) + responsiveWidth(30),
          backgroundColor: ConstantColors.primary,
          child: Text(
            'Tap to send SOS',
            style: Styles.getDefaultWhite(
              weight: ConstantSizes.fontWeightSemiBold
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}