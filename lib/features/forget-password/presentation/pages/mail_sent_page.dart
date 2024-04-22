import 'dart:ui';

import 'package:estegatha/features/sign-in/presentation/pages/sing_in_page.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';

class MailSentPage extends StatelessWidget {
  MailSentPage({super.key, required this.email});

  final String email;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: ConstantSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 350,
                width: 350,
                child: Image(
                  image: AssetImage(ConstantImages.mailSentPng),
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                "Password Reset Email Sent",
                style: TextStyle(
                    fontSize: ConstantSizes.headingMd,
                    fontWeight: ConstantSizes.fontWeightBold,
                    color: ConstantColors.primary),
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Text(
                email,
                style: const TextStyle(color: ConstantColors.primary),
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              const Text(
                "Your account security is important to us. We've sent you a secure link to safely change your password and keep your account protected.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: ConstantSizes.fontSizeSm,
                    color: ConstantColors.darkGrey),
              ),
              const SizedBox(height: ConstantSizes.spaceBtwSections),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return SignInPage();
                  }));
                },
                labelText: "Done",
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              TextButton(
                onPressed: () async {
                  // TODO: Implement resend email functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        children: [
                          CircularProgressIndicator(
                            strokeAlign: BorderSide.strokeAlignCenter,
                            strokeWidth: 2,
                          ),
                          SizedBox(width: ConstantSizes.spaceBtwItems),
                          Text("Resending email..."),
                        ],
                      ),
                    ),
                  );

                  await Future.delayed(
                      const Duration(seconds: 1)); // simulate delay

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Email sent"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text("Resend Email"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
