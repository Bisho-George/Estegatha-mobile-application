import 'package:estegatha/features/safty/domain/model/health_welcome_model.dart';
import 'package:flutter/material.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/sizes.dart';
class HealthWelcomeWidget extends StatelessWidget {
  HealthWelcomeWidget({
    super.key,
    required this.healthWelcomeModel
  });
  HealthWelcomeModel healthWelcomeModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image(
          image: AssetImage(healthWelcomeModel.imagePath),
          width: double.infinity,
          height: responsiveHeight(325),
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: responsiveHeight(65),
        ),
        SizedBox(
          width: responsiveWidth(320),
          child: Text(
            healthWelcomeModel.title,
            style: Styles.getDefaultPrimary(
              fontSize: 36,
              weight: ConstantSizes.fontWeightSemiBold,
            ),
          ),
        ),
      ],
    );
  }
}