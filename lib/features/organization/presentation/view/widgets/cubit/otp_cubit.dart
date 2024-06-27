import 'package:bloc/bloc.dart';
import 'package:estegatha/features/organization/domain/api/organization_api.dart';

import 'package:meta/meta.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  // HttpClient http = HttpClient();

  Future<void> submit(String otp) async {
    emit(OtpLoading() as OtpState);

    // Check the database for an organization with the entered OTP
    // final dbHelper = DatabaseHelper.instance;
    final organization = OrganizationHttpClient.getOrganizationByCode(otp);

    print("===========================================");
    print(organization);
    print("===========================================");

    if (organization == null) {
      emit(OtpFailure(errMessage: 'Invalid OTP'));
      return;
    }

    // If an organization is found, emit a new state with the organization's name
    emit(OtpSuccess(organization));

    // Future.delayed(Duration(milliseconds: 500), () {
    //   isSubmitted = false;
    // });
  }
}
