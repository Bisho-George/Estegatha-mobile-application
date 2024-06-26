import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/sign-in/data/api/signin_http_client.dart';
import 'package:estegatha/features/sign-in/data/api/user_http_client.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void setUser(Member user) {
    emit(UserLoaded(user));
  }

  Member? getCurrentUser() {
    if (state is UserLoaded) {
      return (state as UserLoaded).user;
    }
    return null;
  }

  Future<Member?> getUserById(int id) async {
    emit(UserLoading());

    try {
      final response = await SignInHttpClient.getUserById(id);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final member = Member(
          id: responseBody['id'],
          username: responseBody['username'].toString(),
          email: responseBody['email'].toString(),
          address: responseBody['address'].toString(),
          phone: responseBody['phone'].toString(),
          image: responseBody['image'].toString(),
          sosPin: responseBody['sosPin'].toString(),
          accessToken: responseBody['tokens']["accessToken"].toString(),
          refreshToken: responseBody['tokens']["refreshToken"].toString(),
        );

        emit(UserSuccess(member));
        return member;
      } else {
        print('Response body: ${response.body}');
        emit(const UserFailure(errMessage: "Failed to get user details!"));
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      emit(const UserFailure(errMessage: "Failed to get user details!"));
      return null;
    }
  }

  // void logout() {
  //   emit(UserInitial());
  // }

  Future<void> deleteUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('currentOrganizationId');
  }

  void logout(BuildContext context) async {
    emit(UserInitial());
    await deleteUserFromPreferences();
    context.read<CurrentOrganizationCubit>().resetCurrentOrganizationState();

    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: SignInPage(),
      withNavBar: false,
    );
  }
}
