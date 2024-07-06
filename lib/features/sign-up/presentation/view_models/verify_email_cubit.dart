import 'package:estegatha/features/sign-in/data/api/signin_http_client.dart';
import 'package:estegatha/features/sign-up/data/models/resend_otp_request.dart';
import 'package:estegatha/features/sign-up/data/models/verify_otp_request.dart';
import 'package:estegatha/features/sign-up/domain/use_cases/verify_otp_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/helpers/getters.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit(this.verifyOtpUseCase) : super(VerifyEmailInitial());

  final VerifyOtpUseCase verifyOtpUseCase;
  String? otp;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  void updateOtp(String otp) {
    this.otp = otp;
    emit(OtpUpdatedState(otp));
  }

  Future<void> verifyEmail() async {
    String? email = Getters.getEmail();
    if (otp != null && email != null) {
      emit(VerifyEmailLoadingState());
      var result = await verifyOtpUseCase
          .call(VerifyOtpRequest(email: email, otp: otp!));
      result.fold((failure) {
        emit(VerifyEmailFailureState(failure.message));
      }, (response) async {
        emit(VerifyEmailSuccessState(response.message));
        try {
          String? password = await storage.read(key: 'password');
          var result = await SignInHttpClient.login(email, password!);
          print(result);
        } catch (e) {
          emit(VerifyEmailFailureState(e.toString()));
        }
      });
    } else {
      emit(VerifyEmailFailureState("Otp is required"));
    }
  }


}
