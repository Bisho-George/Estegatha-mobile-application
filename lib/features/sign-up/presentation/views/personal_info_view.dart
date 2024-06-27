import 'package:estegatha/features/sign-up/presentation/views/widgets/personal_info_form.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';


class PersonalInfoView extends StatelessWidget {
  static String routeName = 'sign-up/personal-info';


  PersonalInfoView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SignUpHeader(
                title: "Personal Info.",
                subtitle: "Please enter your personal information",
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              PersonalInfoForm(),
            ],
          ),
        ),
      ),
    );
  }
}