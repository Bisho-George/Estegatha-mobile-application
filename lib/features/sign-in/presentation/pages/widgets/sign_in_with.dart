import 'package:estegatha/features/sign-in/presentation/pages/sign_in_with_phone_page.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class SignInWith extends StatelessWidget {
  const SignInWith({
    super.key,
    required this.icon,
    required this.toPage,
  });

  final Icon icon;
  final String toPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: ConstantColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            iconSize: ConstantSizes.iconLg,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    if (toPage == "phone") {
                      return SignInWithPhonePage();
                    } else if (toPage == "email") {
                      return SignInPage();
                    }

                    return SignInPage();
                  },
                ),
              );
            },
            icon: Icon(
              icon.icon,
              color: ConstantColors.primary,
            ),
          ),
        ),
        const SizedBox(
          width: ConstantSizes.spaceBtwItems,
        ),
      ],
    );
  }
}
