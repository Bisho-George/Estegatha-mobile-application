import 'dart:convert';
import 'package:estegatha/features/organization/domain/api/organization_api.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  OrganizationCubit() : super(const OrganizationInitial());

  Future<void> createOrganization(BuildContext context,
      {required String name, String? type}) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      // final userId = (userCubit.state as UserLoaded).user.id;
      emit(const OrganizationLoading());

      try {
        print("Enter try block");
        final res = await OrganizationHttpClient.createOrganization(
            name, type = 'default');

        if (res.statusCode == 201) {
          final responseBody = jsonDecode(res.body);
          final organization = Organization.fromJson(responseBody);

          emit(OrganizationCreationSuccess(organization));
        } else {
          emit(const OrganizationFailure(
              errMessage: "Something went wrong, try again!"));
        }
      } catch (e) {
        print(e);
        emit(const OrganizationFailure(
            errMessage: "Failed to create organization!"));
      }
    }
  }

  Future<void> joinOrganizationByCode(BuildContext context, String code) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      emit(const JoinOrganizationLoading());

      try {
        final response = await OrganizationHttpClient.joinOrganizationByCode(
            code, 16); //TODO: orgId => static value for now

        if (response.statusCode == 200) {
          emit(const OrganizationJoinSuccess());
        } else {
          emit(const OrganizationFailure(
              errMessage: "Something went wrong, try again!"));
        }
      } catch (e) {
        print(e);
        emit(const OrganizationFailure(
            errMessage: "Failed to join organization!"));
      }
    } else {
      emit(const OrganizationFailure(
          errMessage: "No user loaded! Cannot join organization."));
    }
  }

  Future<Organization?> getOrganizationById(int orgId) async {
    emit(const OrganizationLoading());

    try {
      final res = await OrganizationHttpClient.getOrganizationById(orgId);

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        final organization = Organization.fromJson(responseBody);

        emit(OrganizationDetailSuccess(organization));
        return organization;
      } else {
        emit(const OrganizationFailure(
            errMessage: "Something went wrong, try again!"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(const OrganizationFailure(
          errMessage: "Failed to get organization details!"));
    }

    return null;
  }

  Future<List<OrganizationMember>> getOrganizationMembers(int orgId) async {
    emit(const OrganizationMembersLoading());

    try {
      final res = await OrganizationHttpClient.getOrganizationMembers(orgId);

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        final members = (responseBody as List)
            .map((member) => OrganizationMember.fromJson(member))
            .toList();

        emit(OrganizationMembersSuccess(members));
        return members;
      } else {
        emit(const OrganizationFailure(
            errMessage: "Something went wrong, try again!"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(const OrganizationFailure(
          errMessage: "Failed to get organization members!"));
    }

    return [];
  }
}
