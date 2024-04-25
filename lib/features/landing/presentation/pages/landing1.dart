import 'package:estegatha/features/landing/domain/models/landing_featues.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

import '../../../sign-in/presentation/pages/sign_in_page.dart';
import 'landing2.dart';

class Landing1 extends StatelessWidget {
  const Landing1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                  'Estegatha',
                  style:Styles.getPrimaryLarge()
              ),
            ),
            Image.asset(
              ConstantImages.onBoardingImage2,
              width: double.infinity,
              height: 268.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 100.0,
              child: PageView.builder(
                  itemCount: Features.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return Text(
                      Features.feature(index),
                      style: Styles.getPrimaryMedium(),
                      textAlign: TextAlign.center,
                    );
                  }
              )
            ),
            CustomElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Landing2()
                  ),
                );
              },
              labelText: 'Get started',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: Styles.getDefaultPrimary(),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign in',
                    style:Styles.getDefaultPrimary(
                        weight: ConstantSizes.fontWeightExtraBold
                    ),
                  ),
                ),
              ],
            )
          ]
      ),
    );
  }
}