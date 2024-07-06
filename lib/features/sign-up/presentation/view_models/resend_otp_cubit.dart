import 'package:bloc/bloc.dart';
import 'package:estegatha/utils/helpers/getters.dart';
import 'package:meta/meta.dart';

import '../../data/models/resend_otp_request.dart';
import '../../domain/use_cases/resend_otp_use_case.dart';

part 'resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  ResendOtpCubit(this.resendOtpUseCase) : super(ResendOtpInitial());
  final ResendOtpUseCase resendOtpUseCase;

  Future<void> resendOtp() async {
    emit(ResendOtpLoadingState());
    if (Getters.getEmail() != null) {
      var result =
      await resendOtpUseCase.call(ResendOtpRequest(email: Getters.getEmail()!));
    result.fold((failure) {
    emit(ResendOtpFailureState(failure.message));
    }, (response) {
    emit(ResendOtpSuccessState(response.message));
    });
  }
  }
}
