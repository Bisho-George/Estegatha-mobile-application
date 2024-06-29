import 'package:bloc/bloc.dart';
import 'package:estegatha/features/sign-in/data/api/signin_http_client.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future checkEmailToResetPassword({required String email}) async {
    emit(ForgetPasswordLoading());

    try {
      final response = await SignInHttpClient.resetPasswordEmail(email);

      if (response.statusCode == 200) {
        emit(ForgetPasswordSuccess());
      } else {
        emit(ForgetPasswordFailure(errMessage: "Failed to send email!"));
        print("response: ${response.body}");
      }
    } catch (e) {
      emit(ForgetPasswordFailure(errMessage: "Email not found!"));
      return;
    }
  }

  Future changePassword(
      {required String email,
      required String newPassword,
      required String token}) async {
    emit(ChangePasswordLoading());

    try {
      final response =
          await SignInHttpClient.changePassword(email, newPassword, token);

      if (response.statusCode == 200) {
        emit(ChangePasswordSuccess());
      } else {
        emit(ChangePasswordFailure(errMessage: "Failed to send email!"));
        print("response: ${response.body}");
      }
    } catch (e) {
      emit(ChangePasswordFailure(errMessage: "Email not found!"));
      return;
    }
  }
}
