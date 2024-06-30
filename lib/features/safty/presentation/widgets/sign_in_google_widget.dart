import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../responsive/size_config.dart';
import '../../../../utils/common/styles/text_styles.dart';
import '../../../../utils/constant/image_strings.dart';

class SignInGoogleWidget extends StatelessWidget {
  SignInGoogleWidget({super.key, required this.onTap});

  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: responsiveHeight(60),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF747775)),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              fit: BoxFit.cover,
              ConstantImages.googleIcon,
              width: responsiveWidth(30),
              height: responsiveHeight(25),
            ),
            const SizedBox(width: 10),
            Text(
              'Sign in with Google',
              style: Styles.getDefaultPrimary().copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
