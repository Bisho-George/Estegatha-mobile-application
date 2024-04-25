import 'package:estegatha/features/landing/presentation/pages/landing1.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

import '../../../sign-in/presentation/pages/sign_in_page.dart';


class LandingIntro extends StatelessWidget {
  const LandingIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF03045E),
              Color(0xFF4F8EB9),
              Color(0xFFF3F7FA)
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 28.0),
              child: Text(
                'More Safety,',
                style: Styles.getWhiteMedium()
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(right: 28.0),
              child: Text(
                'More confident',
                style: Styles.getWhiteMedium()
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Image.asset(
                ConstantImages.AppLogo,
                width: 200.0,
                height: 200.0,
              ),
            ),
            Text(
                'Estegatha',
              style: Styles.getWhiteLarge()
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 14.0),
              child: CustomElevatedButton(
                labelText: "Get Started",
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Landing1(),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have account?',
                    style: Styles.getDefaultPrimary()
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: Styles.getDefaultPrimary(weight: ConstantSizes.fontWeightExtraBold)
                      )
                  )
                ],
            )
          ],
        ),
      ),
    );
  }
}