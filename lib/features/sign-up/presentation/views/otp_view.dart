import 'package:dio/dio.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/login_cubit/login_cubit.dart';
import 'package:estegatha/features/sign-up/data/data_source/resend_otp_data_source.dart';
import 'package:estegatha/features/sign-up/data/repos/resend_otp_repo_imp.dart';
import 'package:estegatha/features/sign-up/data/repos/verify_otp_repo_imp.dart';
import 'package:estegatha/features/sign-up/domain/use_cases/verify_otp_use_case.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/verify_email_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/otp_fields.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/progress_indicator.dart';
import 'package:estegatha/features/sign-up/presentation/views/widgets/sign_up_header.dart';
import 'package:estegatha/main_menu.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/services/api_service.dart';
import '../../../landing/presentation/pages/landing_intro.dart';
import '../../data/data_source/verify_otp_data_source.dart';
import '../../domain/use_cases/resend_otp_use_case.dart';
import '../logic/time_manager.dart';
import '../view_models/otp_view_model.dart';
import '../view_models/resend_otp_cubit.dart';

class OtpView extends StatefulWidget {
  OtpView({super.key});

  static const String routeName = 'sign-up/otp';

  @override
  _OtpViewState createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  int _timeRemaining = 0;
  TimerManager _timerManager = TimerManager();
  bool _isResendButtonDisabled = false;
  OtpViewModel _otpViewModel = OtpViewModel(SignUpViewModel());

  @override
  void initState() {
    super.initState();
    _startTimer(120);
  }

  void _startTimer(int time) {
    setState(() {
      _isResendButtonDisabled = true;
    });
    _timerManager.startTimer(120, (remainingTime) {
      setState(() {
        _timeRemaining = remainingTime;
      });
    }, () {
      setState(() {
        _timeRemaining = 0;
        _isResendButtonDisabled = false;
      });
    });
  }

  void _resetTimer() {
    _timerManager.resetTimer(120, (remainingTime) {
      setState(() {
        _timeRemaining = remainingTime;
      });
    }, () {
      setState(() {
        _timeRemaining = 0;
        _isResendButtonDisabled = false;
      });
    });
  }

  @override
  void dispose() {
    _timerManager.cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerifyEmailCubit>(
          create: (_) => VerifyEmailCubit(
            VerifyOtpUseCase(
              VerifyOtpRepoImp(
                verifyOtpDataSource: VerifyOtpDataSourceImp(ApiService(Dio())),
              ),
            ),
          ),
        ),
        BlocProvider<ResendOtpCubit>(
          create: (_) => ResendOtpCubit(
            ResendOtpUseCase(
              ResendOtpRepoImp(
                resendOtpDataSource: ResendOtpDataSourceImp(ApiService(Dio())),
              ),
            ),
          ),
        ),
      ],
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
                Form(
                  key: _otpViewModel.signUpViewModel.otpFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsiveWidth(ConstantSizes.defaultSpace),
                    ),
                    child: Column(
                      children: [
                        OtpFields(signUpViewModel: _otpViewModel.signUpViewModel),
                        const SizedBox(height: ConstantSizes.spaceBtwItems),
                        Text(
                          _timeRemaining > 0
                              ? 'OTP expires in $_timeRemaining seconds'
                              : 'OTP expired',
                        ),
                        const Text(
                          "Didn’t Receive OTP?",
                          style: TextStyle(
                            color: ConstantColors.darkGrey,
                            fontWeight: ConstantSizes.fontWeightRegular,
                            fontSize: ConstantSizes.md,
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            return TextButton(
                              onPressed: _isResendButtonDisabled
                                  ? null
                                  : () {
                                BlocProvider.of<ResendOtpCubit>(context)
                                    .resendOtp();
                                _resetTimer();
                              },
                              child: Text(
                                "Resend Code",
                                style: TextStyle(
                                  color: _isResendButtonDisabled ? ConstantColors.buttonDisabled : ConstantColors.textPrimary,
                                  fontWeight: ConstantSizes.fontWeightBold,
                                  fontSize: ConstantSizes.md,
                                ),
                              ),
                            );
                          },
                        ),
                        ProgressIndicatorBar(
                          percentage: .5,
                          step: "2",
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        Builder(
                          builder: (context) {
                            return CustomElevatedButton(
                              onPressed: () {
                                if (_otpViewModel.signUpViewModel.otpFormKey.currentState!
                                    .validate()) {
                                  String otp = _otpViewModel.getOtp();
                                  BlocProvider.of<VerifyEmailCubit>(context)
                                      .updateOtp(otp);
                                  BlocProvider.of<VerifyEmailCubit>(context)
                                      .verifyEmail();
                                  // Handle OTP submission
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                                }
                              },
                              labelText: "Next",
                            );
                          },
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
