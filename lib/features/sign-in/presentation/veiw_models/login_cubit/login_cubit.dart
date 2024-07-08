import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:estegatha/core/firebase/cloud_messaging.dart';
import 'package:estegatha/features/home/presentation/view_models/current_oragnization_cubit/current_organization_cubit.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/sign-in/data/api/signin_http_client.dart';
import 'package:estegatha/features/sign-in/data/api/user_http_client.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/constant/variables.dart';
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
    print("URI => ${ConstantVariables.uri}");
    try {
      final response = await SignInHttpClient.login(email, password);

      if (response.statusCode == 200) {
        final user = Member.fromJson(jsonDecode(response.body));

        // Stor the user data in User cubit
        BlocProvider.of<UserCubit>(context).setUser(user);

        // Store the user in shared preferences
        final prefs = await SharedPreferences.getInstance();
        String userJson = jsonEncode(user.toJson());
        await prefs.setString('user', userJson);

        emit(LoginSuccess());

        // get user organization
        final userOrganizationResponse =
            await UserHttpClient.getUserOrganizations(user.id);
        if (userOrganizationResponse.statusCode == 200) {
          print("======= After login, enter user organizations ======");
          List<dynamic> jsonResponse =
              jsonDecode(userOrganizationResponse.body);
          // Convert each item in the list to an Organization object
          List<Organization> userOrganizations = jsonResponse
              .map(
                  (organizationJson) => Organization.fromJson(organizationJson))
              .toList();
          // List<Organization> userOrganizations =
          //     jsonDecode(userOrganizationResponse.body);
          if (userOrganizations.isNotEmpty) {
            // join the notification system for each organization
            await joinNotificationSystem(userOrganizations);
          }

          // store the first organization in the current organization
          context
              .read<CurrentOrganizationCubit>()
              .setCurrentOrganization(userOrganizations.first);
        } else {
          // Handle the case where fetching organizations failed
          print("Failed to fetch user organizations");
        }

        print(
            "User object from shared preferences => ${prefs.getString('user')}");
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
