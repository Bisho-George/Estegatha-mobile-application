import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../utils/common/widgets/custom_app_bar.dart';

class HealthTrackerDataPage extends StatelessWidget {
  const HealthTrackerDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Health Tracker'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
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
                              value: 0.82,
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
                              '82%',
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
                                '80',
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
            ),
            Container(
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
                    'Blood Pressure',
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
                        '120/80',
                        style: Styles.getPrimaryLarge(),
                      ),
                      SizedBox(
                        width: responsiveWidth(4),
                      ),
                      Text(
                        'mm Hg',
                        style: Styles.getDefaultPrimary(
                          fontSize: ConstantSizes.fontSizeSm,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
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
                    'Steps',
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
                        '3015',
                        style: Styles.getPrimaryLarge(),
                      ),
                      SizedBox(
                        width: responsiveWidth(4),
                      ),
                      Text(
                        'Avg steps Today',
                        style: Styles.getDefaultPrimary(
                          fontSize: ConstantSizes.fontSizeSm,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
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
                    'nutrition',
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
                        '112 kcal',
                        style: Styles.getPrimaryLarge(),
                      ),
                      SizedBox(
                        width: responsiveWidth(4),
                      ),
                      Text(
                        'mm Hg',
                        style: Styles.getDefaultPrimary(
                          fontSize: ConstantSizes.fontSizeSm,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
