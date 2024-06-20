import 'package:estegatha/features/sign-in/presentation/pages/widgets/form_dvider.dart';
import 'package:estegatha/features/sign-in/presentation/pages/widgets/sign_in_form.dart';
import 'package:estegatha/features/sign-in/presentation/pages/widgets/sign_in_header.dart';
import 'package:estegatha/features/sign-in/presentation/pages/widgets/sign_in_with.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/login_cubit/login_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/views/personal_info_view.dart';
import 'package:estegatha/home_page.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  static String routeName = '/sign-in';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        } else if (state is LoginFailure) {
          HelperFunctions.showSnackBar(context, state.errMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall:
            context.select((LoginCubit cubit) => cubit.state is LoginLoading),
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Flutter Demo'),
          // ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: ConstantSizes.appBarHeight + ConstantSizes.defaultSpace,
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
                        const SignInHeader(),

                        // FORM
                        SignInForm(signInWithPhone: false),

                        // Divider
                        const FormDivider(dividerText: ("Or Sign in With")),

                        const SizedBox(height: ConstantSizes.spaceBtwItems),

                        const SignInWith(
                            icon: Icon(Icons.phone), toPage: "phone"),

                        const SizedBox(
                          height: ConstantSizes.spaceBtwSections,
                        ),

                        // Create Account
                        Column(
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: ConstantColors.darkGrey,
                                fontSize: ConstantSizes.fontSizeMd,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Navigate to sign up page
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return PersonalInfoView();
                                }));

                              },
                              child: const Text(
                                "Create Account",
                                style: TextStyle(
                                    fontSize: ConstantSizes.fontSizeMd),
                              ),
                            )
                          ],
                        ),
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
