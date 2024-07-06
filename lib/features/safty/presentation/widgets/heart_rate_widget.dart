import 'package:flutter/material.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/sizes.dart';
class HeartRateWidget extends StatelessWidget {
  HeartRateWidget({
    super.key,
    required this.heartRate,
    required this.quality
  });
  String heartRate;
  double quality;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: responsiveWidth(370),
      height: responsiveHeight(250),
      decoration: BoxDecoration(
        color: ConstantColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(
            height: responsiveHeight(20),
          ),
          Text(
            'Health Rate',
            style: Styles.getPrimaryLarge(),
          ),
          SizedBox(
            height: responsiveHeight(20),
          ),
          Row(
            children: [
              SizedBox(
                width: responsiveWidth(40),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: responsiveHeight(120),
                    width: responsiveWidth(120),
                    child: CircularProgressIndicator(
                      value: quality / 100,
                      color: ConstantColors.primary,
                      backgroundColor: ConstantColors.white,
                      strokeWidth: 10,
                    ),
                  ),
                  Positioned(
                    top: responsiveHeight(30),
                    child: Text(
                      'Quality',
                      style: Styles.getDefaultPrimary(
                          fontSize: ConstantSizes.fontSizeLg),
                    ),
                  ),
                  Positioned(
                    bottom: responsiveHeight(30),
                    child: Text(
                      '$quality',
                      style: Styles.getPrimaryMedium(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: responsiveWidth(40),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        heartRate,
                        style: Styles.getPrimaryMedium(),
                      ),
                      Text(
                        'bpm',
                        style: Styles.getDefaultPrimary(
                          fontSize: ConstantSizes.fontSizeSm,
                          weight: ConstantSizes.fontWeightSemiBold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Avg heart rate',
                    style: Styles.getDefaultPrimary(
                      fontSize: ConstantSizes.fontSizeSm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}