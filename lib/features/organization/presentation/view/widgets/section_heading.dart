import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 28.h,
      color: ConstantColors.lightContainer,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: ConstantSizes.defaultSpace),
          child: Text(
            title,
            style: TextStyle(
              color: ConstantColors.darkGrey,
              fontSize: ConstantSizes.fontSizeSm.sp,
              fontWeight: ConstantSizes.fontWeightExtraBold,
            ),
          ),
        ),
      ),
    );
  }
}
