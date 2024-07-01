import 'dart:ui';

import 'package:estegatha/constants.dart';
import 'package:estegatha/features/forget-password/presentation/pages/forget_password_screen_3.dart';
import 'package:estegatha/features/forget-password/presentation/pages/mail_sent_page.dart';
import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPasswordScreen_2 extends StatelessWidget {
  String email;
  String newPassword;
  ForgetPasswordScreen_2(
      {super.key, required this.email, required this.newPassword});

  final GlobalKey<FormState> formKey = GlobalKey();

  // email controller
  TextEditingController verificationCode = TextEditingController();
  // TextEditingController newPassword = TextEditingController();
  // TextEditingController confirmNewPassword = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          isLoading = true;
        } else if (state is ResetPasswordSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ForgetPasswordScreen_3();
              },
            ),
          );
        } else if (state is ResetPasswordFailure) {
          HelperFunctions.showSnackBar(context, state.errMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: context.select(
            (ForgetPasswordCubit cubit) => cubit.state is ResetPasswordLoading),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              top: ConstantSizes.appBarHeight,
              left: ConstantSizes.defaultSpace,
              right: ConstantSizes.defaultSpace,
              bottom: ConstantSizes.defaultSpace,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(
                              ConstantSizes.defaultSpace),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: const AssetImage(ConstantImages.AppLogo),
                              height: getProportionateScreenHeight(120),
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              height: ConstantSizes.defaultSpace,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(
                              ConstantSizes.defaultSpace),
                        ),
                        ProgressIndicatorBar(
                          stepTitle: "Enter the verification code",
                          percentage: 0.75,
                          step: "Step 3",
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(
                              ConstantSizes.spaceBtwSections),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                  labelText: "Verification Code",
                                  onChanged: (value) {
                                    verificationCode.text = value;
                                  },
                                  prefixIcon: const Icon(Icons.lock),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Verification code is required";
                                    }

                                    return null;
                                  }),
                              SizedBox(
                                  width: getProportionateScreenWidth(
                                      ConstantSizes.spaceBtwInputFields)),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(
                                ConstantSizes.defaultSpace)),
                        CustomElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ForgetPasswordCubit>(context)
                                .resendResetToken(context, email: email);
                          },
                          labelText: 'Resend',
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(
                                ConstantSizes.defaultSpace)),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              foregroundColor: ConstantColors.light,
                              backgroundColor: ConstantColors.primary,
                              disabledForegroundColor: ConstantColors.darkGrey,
                              disabledBackgroundColor:
                                  ConstantColors.buttonDisabled,
                              side: const BorderSide(
                                  color: ConstantColors.primary),
                              padding: const EdgeInsets.symmetric(
                                  vertical: ConstantSizes.buttonHeight),
                              textStyle: const TextStyle(
                                  fontSize: ConstantSizes.fontSizeMd,
                                  color: ConstantColors.textWhite,
                                  fontWeight: FontWeight.w600),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      ConstantSizes.buttonRadius)),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<ForgetPasswordCubit>(context)
                                    .resetPassword(
                                        email: email,
                                        newPassword: newPassword,
                                        token: verificationCode.text);
                              }
                            },
                            child: const Text('Reset Password'),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(
                              ConstantSizes.spaceBtwSections),
                        ),
                        TextButton(
                            onPressed: () {
                              // navigate to sign in page
                              Navigator.pop(context);
                            },
                            child: const Text("I remembered! Sign in")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
