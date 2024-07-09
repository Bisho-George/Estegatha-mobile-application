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
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(20),
        vertical: responsiveHeight(10),
      ),
      height: responsiveHeight(215),
      decoration: BoxDecoration(
        color: ConstantColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Health Rate',
            style: Styles.getPrimaryLarge(),
          ),
          SizedBox(
            height: responsiveHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: responsiveHeight(120),
                    width: responsiveWidth(120),
                    child: CircularProgressIndicator(
                      value: quality != -1 ? quality / 100 : 0,
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
                      quality != -1 ? '${quality.toStringAsFixed(2)}' : 'N/A',
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