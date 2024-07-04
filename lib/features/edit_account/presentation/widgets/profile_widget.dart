import 'package:estegatha/utils/common/widgets/category_header_widget.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/sizes.dart';
import 'preference_widget.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({super.key, required this.userName});
  String userName;
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryHeaderWidget(name: 'Profile'),
          Container(
            color: Colors.white,
            width: double.infinity,
            height: responsiveHeight(80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Padding(
                  padding:
                      EdgeInsets.only(left: responsiveWidth(ConstantSizes.md)),
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: ConstantColors.iconPrimary,
                          radius: responsiveWidth(20.0),
                          child: Text(
                            userName.isNotEmpty ? userName[0] : '',
                            style: Styles.getDefaultPrimary()
                                .copyWith(color: Colors.white),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: responsiveWidth(ConstantSizes.md)),
                        child: Text(
                          userName,
                          style: Styles.getDefaultPrimary(
                              weight: ConstantSizes.fontWeightBold),
                        ),
                      ),
                    ],
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
        ],
      ),
    );
  }
}
