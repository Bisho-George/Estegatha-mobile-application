import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:meta/meta.dart';

import '../../../organization/domain/api/organization_api.dart';
import '../../../organization/domain/models/organizationMember.dart';
import 'current_oragnization_cubit/current_organization_cubit.dart';

part 'organization_member_state.dart';

class OrganizationMemberHomeCubit extends Cubit<OrganizationMemberHomeState> {
  OrganizationMemberHomeCubit() : super(OrganizationMemberHomeInitial());
  
  Future<void> getCurrentOrganizationMembers() async {
    try {
      emit(OrganizationMemberHomeLoading());
      final CurrentOrganizationCubit currentOrganizationCubit = CurrentOrganizationCubit();
      await currentOrganizationCubit.loadCurrentOrganization();
      Organization? organization = currentOrganizationCubit.currentOrganization;
      if (organization != null) {
         var result = await getOrganizationMembers(organization!.id!);
        emit(OrganizationMemberHomeSuccess(result));
      } else {
        emit(OrganizationMemberHomeFailure("Failed to get organization members!"));
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
  Future<List<OrganizationMember>> getOrganizationMembers(int orgId) async {
    try {
      final res = await OrganizationHttpClient.getOrganizationMembers(orgId);

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        final members = (responseBody as List)
            .map((member) => OrganizationMember.fromJson(member))
            .toList();
        // emit(OrganizationSuccess(members: members, []));
        return members;
      } else {
        print ('Failed to get organization members');
      }
    } catch (e) {
      print('Exception: $e');

    }

    return [];
  }


}
