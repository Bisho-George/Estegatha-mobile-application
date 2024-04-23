import 'package:flutter/material.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/constant/sizes.dart';

class SignUpHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SignUpHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 210,
      padding: EdgeInsets.all(ConstantSizes.defaultSpace),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.00, 1.00),
          end: Alignment(0, -1),
          colors: [Color(0xFFF0F1F4), Color(0x00F0F1F4)],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: ConstantColors.primary,
                      fontSize: ConstantSizes.headingMd,
                      fontWeight: ConstantSizes.fontWeightSemiBold,
                    )),
                Text(
                  subtitle,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: ConstantSizes.fontSizeSm,
                      fontWeight: ConstantSizes.fontWeightRegular,
                      color: ConstantColors.textSecondary),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: ConstantSizes.defaultSpace,
                  top: ConstantSizes.defaultSpace
              ),
              child: Column(
                children: [
                  Image.asset(
                    ConstantImages.signUpPng,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
