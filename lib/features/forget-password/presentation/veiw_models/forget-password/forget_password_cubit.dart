import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:estegatha/features/sign-in/data/api/signin_http_client.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future createResetToken({required String email}) async {
    emit(CreateResetTokenLoading());

    try {
      final response = await SignInHttpClient.createResetToken(email);

      if (response.statusCode == 201) {
        emit(CreateResetTokenSuccess());
      } else if (jsonDecode(response.body)['success'] == false &&
          jsonDecode(response.body)['message']
              .toString()
              .contains("No User with This Email")) {
        emit(CreateResetTokenFailure(
            errMessage: jsonDecode(response.body)['message']));
        print("response: ${response.body}");
      } else if (jsonDecode(response.body)['success'] == false &&
          (jsonDecode(response.body)['message'])
              .toString()
              .contains("duplicate key value violates unique constraint")) {
        emit(CreateResetTokenFailure(
            errMessage: "Reset password session is already created!"));
        print("response: ${response.body}");
      } else {
        emit(CreateResetTokenFailure(errMessage: "Failed to send email!"));
        print("response: ${response.body}");
      }
    } catch (e) {
      emit(CreateResetTokenFailure(errMessage: "Email not found!"));
      return;
    }
  }

  Future sendResetToken({required String email}) async {
    emit(SendResetTokenLoading());

    try {
      final response = await SignInHttpClient.sendResetToken(email);

      if (response.statusCode == 200) {
        emit(SendResetTokenSuccess());
      } else {
        emit(SendResetTokenFailure(errMessage: "Failed to send email!"));
        print("response: ${response.body}");
      }
    } catch (e) {
      emit(SendResetTokenFailure(errMessage: "Email not found!"));
      return;
    }
  }

  Future resendResetToken(BuildContext context, {required String email}) async {
    emit(SendResetTokenLoading());

    try {
      final response = await SignInHttpClient.sendResetToken(email);

      if (response.statusCode == 200) {
        emit(SendResetTokenSuccess());

        HelperFunctions.showSnackBar(context, "Reset link sent");
      } else {
        emit(SendResetTokenFailure(errMessage: "Failed to send email!"));
        print("response: ${response.body}");
      }
    } catch (e) {
      emit(SendResetTokenFailure(errMessage: "Email not found!"));
      return;
    }
  }

  Future resetPassword(
      {required String email,
      required String newPassword,
      required String token}) async {
    emit(ResetPasswordLoading());

    try {
      final response =
          await SignInHttpClient.resetPassword(email, newPassword, token);

      if (response.statusCode == 200) {
        emit(ResetPasswordSuccess());
      } else {
        emit(ResetPasswordFailure(errMessage: "Failed to send email!"));
        print("response: ${response.body}");
      }
    } catch (e) {
      emit(ResetPasswordFailure(errMessage: "Email not found!"));
      return;
    }
  }
}
