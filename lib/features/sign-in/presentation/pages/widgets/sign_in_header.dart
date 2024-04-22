import "package:estegatha/utils/constant/colors.dart";
import "package:estegatha/utils/constant/image_strings.dart";
import "package:estegatha/utils/constant/sizes.dart";
import "package:flutter/material.dart";

class SignInHeader extends StatelessWidget {
  const SignInHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(ConstantImages.AppLogo),
          height: 100,
        ),
        SizedBox(
          height: ConstantSizes.defaultSpace,
        ),
        Text(
          "Welcome Back!",
          style: TextStyle(
            color: ConstantColors.primary,
            fontSize: ConstantSizes.headingMd,
            fontWeight: ConstantSizes.fontWeightBold,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          "Login to your account to reach your friends and family!",
          style: TextStyle(
            color: ConstantColors.darkGrey,
            fontSize: ConstantSizes.fontSizeMd,
          ),
        ),
      ],
    );
  }
}
