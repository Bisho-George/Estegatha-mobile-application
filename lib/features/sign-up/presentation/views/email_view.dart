import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/views/password_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/common/widgets/custom_text_field.dart';
import '../../../../utils/constant/sizes.dart';
import '../../../../utils/helpers/validation.dart';
import '../view_models/sign_up_cubit.dart';

class EmailView extends StatefulWidget {
  EmailView({super.key});

  static const String routeName = 'sign-up/email';

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  SignUpViewModel signUpViewModel = SignUpViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SignUpHeader(
                title: "Email",
                subtitle: "Please enter your email",
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Form(
                key: signUpViewModel.emailFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ConstantSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextField(
                        labelText: "Email",
                        validator: (value) => Validation.validateEmail(value),
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email),
                        controller: signUpViewModel.emailController,
                      ),
                      const SizedBox(
                        height: ConstantSizes.spaceBtwSections,
                      ),
                      ProgressIndicatorBar(
                        percentage: .75,
                        step: "3",
                      ),
                      const SizedBox(
                        height: ConstantSizes.defaultSpace,
                      ),
                      CustomElevatedButton(
                          onPressed: () {
                            if (signUpViewModel.emailFormKey.currentState!
                                .validate()) {
                              String? email = signUpViewModel.emailController.text;
                              BlocProvider.of<SignUpCubit>(context)
                                  .updateEmail(email);
                              Navigator.pushNamed(context, PasswordView.routeName);
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
