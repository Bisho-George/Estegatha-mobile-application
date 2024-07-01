import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/features/sign-up/data/models/signup_request_body.dart';
import 'package:estegatha/features/sign-up/data/models/signup_response.dart';
import 'package:estegatha/features/sign-up/domain/entities/personal_info_entity.dart';
import 'package:estegatha/features/sign-up/domain/entities/user_entity.dart';
import 'package:estegatha/features/sign-up/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signupUseCase) : super(SignUpInitial());

  PersonalInfoEntity? personalInfo;
  String? email;
  String? password;
  String? otp;
  String? address;
  LatLng? location;
  final GetStorage box = GetStorage();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  void updatePersonalInfo(PersonalInfoEntity personalInfoModel) {
    personalInfo = personalInfoModel;
    emit(SignUpPersonalInfoState(personalInfoModel));
  }

  void updateEmail(String email) {
    this.email = email;
    box.write('email', email);
    emit(SignUpEmailState(email));
  }

  void updatePassword(String password) async {
    this.password = password;
    await secureStorage.write(key: 'password', value: password);
    emit(SignUpPasswordState(password));
  }

  void updateOTP(String otp) {
    this.otp = otp;
    emit(SignUpOTPState(otp));
  }

  void updateAddress(String address) {
    this.address = address;
    emit(SignUpAddressState(address));
  }

  void updateLocation(LatLng position) {
    location = position;
    emit(SignUpLatLngState(latitude: position.latitude, longitude: position.longitude));
  }

  final SignupUseCase signupUseCase;

  Future<void> signUp() async {
    if (email != null &&
        password != null &&
        personalInfo != null &&
        address != null &&
        location != null
    ) {
      emit(SignupLoadingState());
      var result = await signupUseCase.call(SignupRequestBody(
        email: email!,
        birthDate: personalInfo!.birthDate!,
        password: password!,
        username: personalInfo!.firstName!,
        phone: personalInfo!.phoneNumber!,
        address: address!,
        lat: location!.latitude.toString(),
        lng: location!.longitude.toString(),
      ));
      result.fold((failure) {
        emit(SignupFailureState(failure.message));
      }, (status) {
        emit(SignupSuccessState(status));
      });
    } else {
      emit(SignupFailureState("All fields are required"));
    }
  }
}
