import 'dart:ui';

import 'package:estegatha/features/forget-password/presentation/pages/forget_password_screen_2.dart';
import 'package:estegatha/features/forget-password/presentation/pages/mail_sent_page.dart';
import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
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

class ForgetPasswordScreen_1 extends StatelessWidget {
  String email;

  ForgetPasswordScreen_1({super.key, required this.email});

  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmNewPassword = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        print("State: $state");
        if (state is SendResetTokenLoading) {
          isLoading = true;
        } else if (state is SendResetTokenSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ForgetPasswordScreen_2(
                  email: email,
                  newPassword: _confirmNewPassword.text,
                );
              },
            ),
          );
        } else if (state is SendResetTokenFailure) {
          HelperFunctions.showSnackBar(context, state.errMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: context.select((ForgetPasswordCubit cubit) =>
            cubit.state is SendResetTokenLoading),
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
                          percentage: 0.5,
                          step: "Step 2",
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
                                labelText: "New Password",
                                onChanged: (value) {
                                  _newPassword.text = value;
                                },
                                prefixIcon: const Icon(Icons.password),
                                validator: (value) =>
                                    Validation.validatePassword(value),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      ConstantSizes.defaultSpace)),
                              CustomTextField(
                                labelText: "Confirm Password",
                                onChanged: (value) {
                                  _confirmNewPassword.text = value;
                                },
                                prefixIcon: const Icon(Icons.password),
                                validator: (value) =>
                                    Validation.validateConfirmPassword(
                                        _newPassword.text, value!),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(
                                ConstantSizes.spaceBtwItems)),
                        const Padding(
                          padding: EdgeInsets.all(ConstantSizes.sm),
                          child: Text(
                            "Note: Once you click Continue, a verification code will be sent to your email address.",
                            style: TextStyle(color: ConstantColors.darkGrey),
                          ),
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(
                                ConstantSizes.spaceBtwSections * 2)),
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
                                    .sendResetToken(
                                  email: email,
                                );
                              }
                            },
                            child: const Text('Continue'),
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
