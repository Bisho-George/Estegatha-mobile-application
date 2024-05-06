import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common/widgets/custom_elevated_button.dart';
import '../../../../utils/common/widgets/custom_text_field.dart';
import '../../../../utils/constant/sizes.dart';
import '../../../../utils/helpers/validation.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});
  static const String routeName = 'sign-up/password';

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  SignUpViewModel signUpViewModel = SignUpViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SignUpHeader(
                title: "Password",
                subtitle: "Please enter a strong password",
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Form(
                key: signUpViewModel.passwordFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ConstantSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextField(
                        labelText: "Password",
                        validator: (value) =>
                            Validation.validatePassword(value),
                        obscureText: signUpViewModel.obscureText,
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            icon: Icon(
                              signUpViewModel.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                signUpViewModel.togglePasswordVisibility();
                              });
                            }),
                        controller: signUpViewModel.passwordController,
                      ),
                      const SizedBox(
                        height: ConstantSizes.spaceBtwSections,
                      ),
                      ProgressIndicatorBar(
                        percentage: .5,
                        step: "2",
                      ),
                      const SizedBox(
                        height: ConstantSizes.defaultSpace,
                      ),
                      CustomElevatedButton(
                          onPressed: () {
                            if (signUpViewModel.passwordFormKey.currentState!
                                .validate()) {
                              Navigator.pushNamed(context, 'sign-up/otp');
                            }
                          },
                          labelText: "Next")
                    ],
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
