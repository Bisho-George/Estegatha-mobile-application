import 'package:estegatha/features/sign-up/presentation/view_models/otp_timer_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/views/password_view.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/common/widgets/custom_text_field.dart';
import '../../../../utils/constant/sizes.dart';


class OtpView extends StatelessWidget {
  OtpView({super.key});

  static const String routeName = 'sign-up/otp';

  SignUpViewModel signUpViewModel = SignUpViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpTimerCubit(OtpTimerInitial(120))..startTimer(120),
      child: Scaffold(
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
                                    controller: signUpViewModel.otpController1,
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
                                    controller: signUpViewModel.otpController2,
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
                                    controller: signUpViewModel.otpController3,
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
                                    controller: signUpViewModel.otpController4,
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: ConstantSizes.spaceBtwItems,
                          ),
                          BlocListener<OtpTimerCubit, OtpTimerState>(
                            listener: (context, state) {
                              if (state is OtpTimerRunComplete) {
                                signUpViewModel.otpFormKey.currentState!.reset();
                                BlocProvider.of<OtpTimerCubit>(context).cancelTimer();
                              }
                            },
                            child: BlocBuilder<OtpTimerCubit, OtpTimerState>(
                              builder: (context, state) {
                                if (state is OtpTimerRunInProgress) {
                                  return Text('OTP expires in ${state
                                      .timeRemaining} seconds');
                                }
                                else if (state is OtpTimerRunComplete) {
                                  return const Text('OTP expired');
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          const Text(
                            "Didn’t Receive OTP ?",
                            style: TextStyle(
                              color: ConstantColors.darkGrey,
                              fontWeight: ConstantSizes.fontWeightRegular,
                              fontSize: ConstantSizes.md,
                            ),
                          ),
                          const Text(
                            "Resend Code",
                            style: TextStyle(
                                color: ConstantColors.textPrimary,
                                fontWeight: ConstantSizes.fontWeightBold,
                                fontSize: ConstantSizes.md),
                          ),
                          ProgressIndicatorBar(
                            percentage: .5,
                            step: "2",
                          ),
                          const SizedBox(
                            height: ConstantSizes.spaceBtwSections,
                          ),
                          CustomElevatedButton(
                              onPressed: () {
                                if (signUpViewModel.otpFormKey.currentState!
                                    .validate()) {
                                  String? otp =
                                      signUpViewModel.otpController1.text +
                                          signUpViewModel.otpController2.text +
                                          signUpViewModel.otpController3.text +
                                          signUpViewModel.otpController4.text;

                                  Navigator.pushNamed(
                                      context, PasswordView.routeName);
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
      ),
    );
  }
}


