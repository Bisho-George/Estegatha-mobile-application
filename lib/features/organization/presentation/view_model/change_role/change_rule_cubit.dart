import 'dart:convert';

import 'package:estegatha/core/firebase/cloud_messaging.dart';
import 'package:estegatha/features/organization/domain/api/organization_api.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/presentation/view_model/change_role/change_rule_state.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/features/sos/data/api/organizations_api.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeRoleCubit extends Cubit<ChangeRoleState> {
  ChangeRoleCubit() : super(ChangeRoleInitial());

  Future<void> changeMemberRole(
      BuildContext context, int orgId, int userId, String newRole) async {
    final userCubit = context.read<UserCubit>();
    final organizationRes =
        await OrganizationHttpClient.getOrganizationById(orgId);
    final responseBody = jsonDecode(organizationRes.body);
    final organization = Organization.fromJson(responseBody);

    final currentUser = await HelperFunctions.getUser();
    if (userCubit.state is UserLoaded) {
      emit(ChangeRoleLoading());

      try {
        final members =
            await OrganizationsApi().fetchOrganizationMembers(orgId);

        // Check if there's at least one member with a role of 'owner' or 'admin'
        bool hasRequiredRole = members.any((member) =>
            (member.role == 'OWNER' || member.role == 'ADMIN') &&
            member.userId != userId);

        print("====hasRequiredRole: $hasRequiredRole");

        // If trying to change the role of an 'owner' or 'admin', ensure another exists
        if (!hasRequiredRole && (newRole != 'OWNER' && newRole != 'ADMIN')) {
          emit(const ChangeRoleFailure(
              errorMessage: "Must have at least one 'owner' or 'admin'"));
        }

        final response = await OrganizationHttpClient.changeMemberRole(
            orgId, userId, newRole);

        if (response.statusCode == 200) {
          emit(ChangeRoleSuccess());

          await sendNotification(
              userId: currentUser.id,
              subject: "Role Change",
              content: currentUser.id != userId
                  ? "Your role has been changed in ${organization.name} to $newRole"
                  : "A member role has been changed in ${organization.name}. Tab to see the changes.",
              type: "CHANGE_ROLE",
              customData: {
                "userId": userId.toString(),
                "organizationId": orgId.toString(),
              },
              parameters: {
                "organizationId": orgId.toString()
              });
        } else {
          emit(const ChangeRoleFailure(
              errorMessage: "Something went wrong, try again!"));
        }
      } catch (e) {
        print(e);
        emit(
          const ChangeRoleFailure(
              errorMessage: "Failed to change member role!"),
        );
      }
    }
  }
}
