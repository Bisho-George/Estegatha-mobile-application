import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:estegatha/core/firebase/cloud_messaging.dart';
import 'package:estegatha/core/firebase/notification.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/organization_state.dart';
import 'package:estegatha/features/sign-in/data/api/signin_http_client.dart';
import 'package:estegatha/features/sign-in/data/api/user_http_client.dart';
import 'package:estegatha/features/sign-in/presentation/pages/sign_in_page.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
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
        final member = Member.fromJson(responseBody);

        emit(UserSuccess(member));
        return member;
      } else {
        print('Status code: ${response.statusCode}');
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

  Future<void> deleteUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('currentOrganizationId');
  }

  Future<void> logout(BuildContext context) async {
    final user = await HelperFunctions.getUser();

    // get user organization
    final userOrganizationResponse =
        await UserHttpClient.getUserOrganizations(user.id);
    if (userOrganizationResponse.statusCode == 200) {
      print("======= enter user organizations ======");
      List<dynamic> jsonResponse = jsonDecode(userOrganizationResponse.body);
      // Convert each item in the list to an Organization object
      List<Organization> userOrganizations = jsonResponse
          .map((organizationJson) => Organization.fromJson(organizationJson))
          .toList();

      print("======= organizations length ${userOrganizations.length}");
      if (userOrganizations.isNotEmpty) {
        // join the notification system for each organization
        await exitNotificationSystem(userOrganizations);

        print("Exit notification system for each organization");
      }
    } else if (userOrganizationResponse.statusCode != 200) {
      return print("Failed to fetch user organizations");
    }
    emit(UserInitial());
    await deleteUserFromPreferences();
    // context.read<CurrentOrganizationCubit>().resetCurrentOrganizationState();

    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: SignInPage(),
      withNavBar: false,
    );
  }
}
