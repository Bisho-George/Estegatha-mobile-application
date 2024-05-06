import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/common/widgets/custom_text_field.dart';
import '../../../../utils/constant/sizes.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key});

  static const String routeName = 'sign-up/otp';
  SignUpViewModel signUpViewModel = SignUpViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SignUpHeader(
                title: "Verify OTP",
                subtitle: "Please enter the code we sent to email",
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ConstantSizes.defaultSpace),
                child: Form(
                  key: signUpViewModel.otpFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 68,
                                width: 64,
                                child: CustomTextField(
                                  onChanged: (val) {
                                    if (val.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 68,
                                width: 64,
                                child: CustomTextField(
                                  onChanged: (val) {
                                    if (val.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 68,
                                width: 64,
                                child: CustomTextField(
                                  onChanged: (val) {
                                    if (val.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 68,
                                width: 64,
                                child: CustomTextField(
                                  onChanged: (val) {
                                    if (val.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: ConstantSizes.spaceBtwItems,
                        ),
                        Text(
                          "Didn’t Receive OTP ?",
                          style: TextStyle(
                            color: ConstantColors.darkGrey,
                            fontWeight: ConstantSizes.fontWeightRegular,
                            fontSize: ConstantSizes.md,
                          ),
                        ),
                        Text(
                          "Resend Code",
                          style: TextStyle(
                              color: ConstantColors.textPrimary,
                              fontWeight: ConstantSizes.fontWeightBold,
                              fontSize: ConstantSizes.md),
                        ),
                        ProgressIndicatorBar(
                          percentage: .75,
                          step: "3",
                        ),
                        const SizedBox(
                          height: ConstantSizes.spaceBtwSections,
                        ),
                        CustomElevatedButton(
                            onPressed: () {
                              if (signUpViewModel.otpFormKey.currentState!
                                  .validate()) {
                                Navigator.pushNamed(context, 'sign-up/address');
                              }
                            },
                            labelText: "Next")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
