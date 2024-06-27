import 'dart:convert';

import 'package:estegatha/features/edit_account/domain/model/account_preferences.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../responsive/size_config.dart';

class PreferencesWidget extends StatelessWidget {
  PreferencesWidget({super.key, required this.preference});

  AccountPreferences preference;

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return GestureDetector(
      onTap: preference.propertyAction,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: responsiveHeight(80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: responsiveWidth(ConstantSizes.md)),
              child: Text(
                preference.propertyName,
                style: Styles.getDefaultPrimary(
                    weight: ConstantSizes.fontWeightBold),
              ),
            ),
            const Spacer(),
            Divider(
              color: const Color(0xFFEDEDED),
              thickness: responsiveHeight(1),
              height: responsiveHeight(1),
            ),
          ],
        ),
      ),
    );
  }
}
