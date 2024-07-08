import 'dart:convert';

import 'package:estegatha/features/home/presentation/view_models/current_oragnization_cubit/current_organization_cubit.dart';
import 'package:estegatha/features/organization/domain/api/organization_api.dart';
import 'package:estegatha/features/organization/presentation/view_model/leave_organization/leave_organization_state.dart';
import 'package:estegatha/features/sign-in/data/api/user_http_client.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaveOrganizationCubit extends Cubit<LeaveOrganizationState> {
  LeaveOrganizationCubit() : super(LeaveOrganizationInitial());

  Future<void> leaveOrganization(int organizationId) async {
    emit(LeaveOrganizationLoading());

    try {
      final currentUser = await HelperFunctions.getUser();
      final res = await OrganizationHttpClient.leaveOrganization(
          organizationId, currentUser.id);

      if (res.statusCode == 200) {
        final userOrganizationResponse =
            await UserHttpClient.getUserOrganizations(currentUser.id);

        final responseBody = jsonDecode(userOrganizationResponse.body);
        print("responseBody: ${responseBody[0]}");

        emit(LeaveOrganizationSuccess());
      } else {
        print(res.body);
        emit(
            const LeaveOrganizationFailure("Something went wrong, try again!"));
      }
    } catch (e) {
      emit(const LeaveOrganizationFailure("Failed to leave organization!"));
    }
  }
}
