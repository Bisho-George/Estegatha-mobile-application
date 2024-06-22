import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/sign-in/data/api/signin_http_client.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future loginWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    emit(LoginLoading());
    try {
      print("Entered function");
      final response = await SignInHttpClient.login("/login", email, password);

      print(
          "Response status code => ${response.body} => status code => ${response.statusCode}");

      if (response.statusCode == 200) {
        final user = Member.fromJson(jsonDecode(response.body));

        // Stor the user data in User cubit
        BlocProvider.of<UserCubit>(context).setUser(user);

        // Store the user in shared preferences
        final prefs = await SharedPreferences.getInstance();
        String userJson = jsonEncode(user.toJson());
        await prefs.setString('user', userJson);

        print(
            "User object from shared preferences => ${prefs.getString('user')}");

        emit(LoginSuccess());
      } else if (response.statusCode == 404) {
        emit(LoginFailure(errMessage: "Invalid email or password!"));
      }
    } catch (e) {
      print(e);
      emit(LoginFailure(errMessage: "Login with email failed!"));
      return;
    }
  }

  Future loginWithPhone(
      {required String phone, required String password}) async {
    emit(LoginLoading());
    try {
      // TODO => http request for login with (email, password)
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(errMessage: "Login with phone failed!"));
      return;
    }
  }
}
