import 'package:flutter/material.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';
class HealthMetricesWidget extends StatelessWidget {
  HealthMetricesWidget({
    super.key,
    required this.type,
    required this.value,
    required this.unit
  });
  String type;
  String value;
  String unit;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: responsiveWidth(250),
      height: responsiveHeight(125),
      decoration: BoxDecoration(
        color: ConstantColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          SizedBox(
            height: responsiveHeight(20),
          ),
          Text(
            type,
            style: Styles.getDefaultPrimary(
              weight: ConstantSizes.fontWeightExtraBold,
              fontSize: ConstantSizes.headingMd,
            ),
          ),
          SizedBox(
            height: responsiveHeight(5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: Styles.getPrimaryLarge(),
              ),
              SizedBox(
                width: responsiveWidth(4),
              ),
              Text(
                unit,
                style: Styles.getDefaultPrimary(
                  fontSize: ConstantSizes.fontSizeSm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}