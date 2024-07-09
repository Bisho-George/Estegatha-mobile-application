import 'dart:ui';

import 'package:estegatha/features/forget-password/presentation/pages/mail_sent_page.dart';
import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
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

class ForgetPasswordScreen_3 extends StatelessWidget {
  ForgetPasswordScreen_3({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                          percentage: 1,
                          step: "Step 4",
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(
                              ConstantSizes.spaceBtwSections),
                        ),
                        Container(
                          width: getProportionateScreenWidth(double.infinity),
                          height: getProportionateScreenHeight(250),
                          decoration: BoxDecoration(
                              color: ConstantColors.grey,
                              borderRadius: BorderRadius.circular(
                                  ConstantSizes.buttonRadius)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: ConstantColors.primary,
                                size: getProportionateScreenHeight(100),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(
                                    ConstantSizes.spaceBtwItems),
                              ),
                              Text('Password reseated successfully',
                                  style: TextStyle(
                                    fontSize: SizeConfig.font18,
                                    color: ConstantColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(
                              ConstantSizes.spaceBtwSections),
                        ),
                        CustomElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignInPage();
                              }));
                            },
                            labelText: "Back to Sign In"),
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
