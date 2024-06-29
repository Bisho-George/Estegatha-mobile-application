import 'dart:ui';

import 'package:estegatha/features/forget-password/presentation/pages/mail_sent_page.dart';
import 'package:estegatha/features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/helpers/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();

  String? email;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          isLoading = true;
        } else if (state is ForgetPasswordSuccess) {
          // HelperFunctions.showSnackBar(context, "Reset link sent");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MailSentPage(
                  email: email!,
                );
              },
            ),
          );
        } else if (state is ForgetPasswordFailure) {
          HelperFunctions.showSnackBar(context, state.errMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: context.select((ForgetPasswordCubit cubit) =>
            cubit.state is ForgetPasswordLoading),
        child: Scaffold(
          // appBar: PreferredSize(
          //   preferredSize: const Size.fromHeight(ConstantSizes.appBarHeight),
          //   child: AppBar(
          //     title: const Text(
          //       'Forget Password',
          //       style: TextStyle(
          //         fontSize: ConstantSizes.headingSm,
          //         fontWeight: ConstantSizes.fontWeightBold,
          //       ),
          //     ),
          //   ),
          // ),
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
                        // LOGO, Title, Subtitle
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage(ConstantImages.forgetPassword),
                              height: 300,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: ConstantSizes.defaultSpace,
                            ),
                          ],
                        ),

                        Form(
                          key: formKey,
                          child: CustomTextField(
                            labelText: "Email",
                            onChanged: (value) {
                              email = value;
                            },
                            prefixIcon: const Icon(Icons.email),
                            validator: (value) =>
                                Validation.validateEmail(value),
                          ),
                        ),

                        const SizedBox(height: ConstantSizes.spaceBtwItems),

                        const Padding(
                          padding: EdgeInsets.all(ConstantSizes.sm),
                          child: Text(
                            "Note: Once you click Reset Password, an email verification link will be sent to your email address.",
                            style: TextStyle(color: ConstantColors.darkGrey),
                          ),
                        ),

                        const SizedBox(height: ConstantSizes.spaceBtwSections),

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
                                    .checkEmailToResetPassword(
                                  email: email!,
                                );
                              }
                            },
                            child: const Text('Reset Password'),
                          ),
                        ),

                        const SizedBox(
                          height: ConstantSizes.spaceBtwSections * 2,
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
