import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';

import '../../../responsive/size_config.dart';
import '../styles/text_styles.dart';
import '../../constant/sizes.dart';

class CategoryHeaderWidget extends StatelessWidget {
  const CategoryHeaderWidget({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsiveHeight(30),
      alignment: Alignment.centerLeft,
      color: ConstantColors.softGrey,
      padding: EdgeInsets.only(left: responsiveWidth(ConstantSizes.md)),
      child: Text(
        name,
        style: Styles.getDefaultSecondary(
          weight: ConstantSizes.fontWeightBold,
          fontSize: ConstantSizes.fontSizeLg,
        ).copyWith(color: Color(0xFFC4C4C4)),
      ),
    );
  }
}
