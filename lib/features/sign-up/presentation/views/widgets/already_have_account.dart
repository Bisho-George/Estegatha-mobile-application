
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(
              color: ConstantColors.textSecondary,
              fontWeight: ConstantSizes.fontWeightSemiBold,
              fontSize: ConstantSizes.fontSizeMd),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, SignInPage.routeName);
          },
          child: const Text("Sign in",
              style: TextStyle(
                  color: ConstantColors.textPrimary,
                  fontWeight: ConstantSizes.fontWeightBold,
                  fontSize: ConstantSizes.fontSizeMd)),
        )
      ],
    );
  }
}