import 'package:estegatha/features/landing/presentation/pages/landing1.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

import '../../../sign-in/presentation/pages/sign_in_page.dart';

class LandingIntro extends StatelessWidget {
  const LandingIntro({super.key});

  static const String routeName = '/landing/intro';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: responsiveHeight(70)),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF03045E), Color(0xFF4F8EB9), Color(0xFFF3F7FA)],
          ),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: responsiveWidth(28.0)),
              child: Text('More Safety,', style: Styles.getWhiteMedium()),
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(right: responsiveWidth(28.0)),
              child: Text('More confident', style: Styles.getWhiteMedium()),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: responsiveHeight(48), bottom: responsiveHeight(12.0)),
              child: Image.asset(
                ConstantImages.AppLogo,
                width: responsiveWidth(200.0),
                height: responsiveHeight(200.0),
              ),
            ),
            Text('Estegatha', style: Styles.getWhiteLarge()),
            Padding(
              padding: EdgeInsets.only(
                top: responsiveHeight(120.0),
                bottom: responsiveHeight(14.0),
                left: responsiveWidth(20.0),
                right: responsiveWidth(20.0),
              ),
              child: CustomElevatedButton(
                labelText: "Get Started",
                onPressed: () {
                  Navigator.pushNamed(context, Landing1.routeName);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have account?',
                    style: Styles.getDefaultPrimary()),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInPage(),
                        ),
                      );
                    },
                    child: Text('Sign In',
                        style: Styles.getDefaultPrimary(
                            weight: ConstantSizes.fontWeightExtraBold)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
