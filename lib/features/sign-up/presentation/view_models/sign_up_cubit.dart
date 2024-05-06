import 'package:bloc/bloc.dart';
import 'package:estegatha/features/sign-up/domain/models/personal_info_model.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  void updatePersonalInfo(PersonalInfoModel personalInfoModel) {
    emit(SignUpPersonalInfoState(personalInfoModel));
  }

  void updateEmail(String email) {
    emit(SignUpEmailState(email));
  }

  void updatePassword(String password) {
    emit(SignUpPasswordState(password));
  }

  void updateOTP(String otp) {
    emit(SignUpOTPState(otp));
  }

  void updateAddress(String address) {
    emit(SignUpAddressState(address));
  }
}
