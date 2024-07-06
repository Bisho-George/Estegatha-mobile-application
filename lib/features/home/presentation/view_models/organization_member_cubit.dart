import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../organization/domain/api/organization_api.dart';
import '../../../organization/domain/models/organizationMember.dart';
import '../../../organization/presentation/view_model/current_organization_cubit.dart';

part 'organization_member_state.dart';

class OrganizationMemberHomeCubit extends Cubit<OrganizationMemberHomeState> {
  OrganizationMemberHomeCubit() : super(OrganizationMemberHomeInitial());
  
  Future<void> getCurrentOrganizationMembers() async {
    try {
      emit(OrganizationMemberHomeLoading());
      final CurrentOrganizationCubit currentOrganizationCubit = CurrentOrganizationCubit();
      await currentOrganizationCubit.loadCurrentOrganization();
      int? orgId = currentOrganizationCubit.state.organizationId;
      if (orgId != null) {
         var result = await getOrganizationMembers(orgId);
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
