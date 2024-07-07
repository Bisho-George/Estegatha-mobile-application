// user_organizations_cubit.dart

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/sign-in/data/api/user_http_client.dart';

part 'user_organizations_state.dart';

class UserOrganizationsCubit extends Cubit<UserOrganizationsState> {
  List<Organization> organizations = [];
  UserOrganizationsCubit() : super(UserOrganizationsInitial());

  Future<void> getUserOrganizations(int userId) async {
    emit(UserOrganizationsLoading());

    try {
      final response = await UserHttpClient.getUserOrganizationsWithoutUserId();

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final organizations = <Organization>[];

        for (var org in responseBody) {
          organizations.add(Organization.fromJson(org));
        }

        emit(UserOrganizationsSuccess(organizations));
      } else {
        emit(UserOrganizationsFailure("Something went wrong, try again!"));
      }
    } catch (e) {
      emit(UserOrganizationsFailure("Failed to join organization!"));
    }
  }

  Future<void> getUserOrganizationsWithoutId() async {
    emit(UserOrganizationsLoading());

    try {
      final response = await UserHttpClient.getUserOrganizationsWithoutUserId();

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final organizationsList = <Organization>[];

        for (var org in responseBody) {
          organizationsList.add(Organization.fromJson(org));
        }

        organizations =
            organizationsList; // Update the local organizations list
        emit(UserOrganizationsSuccess(organizations));
      } else {
        emit(UserOrganizationsFailure("Something went wrong, try again!"));
      }
    } catch (e) {
      emit(UserOrganizationsFailure("Failed to join organization!"));
    }
  }
}
