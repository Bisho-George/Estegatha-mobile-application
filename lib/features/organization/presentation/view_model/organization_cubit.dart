import 'dart:convert';
import 'package:estegatha/features/organization/domain/api/organization_api.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/domain/models/post.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/user_organizations_cubit.dart'
    as userOrgCubit;
import 'package:estegatha/features/sign-in/data/api/user_http_client.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  OrganizationCubit() : super(const OrganizationInitial());

  Future<void> createOrganization(BuildContext context,
      {required String name, String? type}) async {
    final userCubit = context.read<UserCubit>();

    if (userCubit.state is UserLoaded) {
      emit(const OrganizationLoading());

      try {
        final res = await OrganizationHttpClient.createOrganization(
            name, type = 'default');

        if (res.statusCode == 201) {
          final responseBody = jsonDecode(res.body);
          final organization = Organization.fromJson(responseBody);

          emit(OrganizationCreationSuccess(organization));

          // update the user organizations
          updateOrganizationsList(context);
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

  Future<void> updateOrganizationsList(BuildContext context) async {
    final userId = BlocProvider.of<UserCubit>(context).getCurrentUser()?.id;
    if (userId != null) {
      context
          .read<userOrgCubit.UserOrganizationsCubit>()
          .getUserOrganizations(userId);
    }
  }

  Future<void> joinOrganizationByCode(BuildContext context, String code) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      emit(const JoinOrganizationLoading());

      try {
        final response =
            await OrganizationHttpClient.joinOrganizationByCode(code);

        if (response.statusCode == 200) {
          final Organization organization =
              Organization.fromJson(jsonDecode(response.body));

          print("Organization: ${organization.id}");
          emit(OrganizationJoinSuccess(organization));
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
      final members = await getOrganizationMembers(orgId);
      final posts = await getOrganizationPosts(orgId);

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        final organization = Organization.fromJson(responseBody);

        emit(OrganizationDetailSuccess(organization,
            members: members, posts: posts));
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

        // emit(OrganizationSuccess(members: members, []));
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

  Future<List<Post>> getOrganizationPosts(int orgId) async {
    emit(const OrganizationPostsLoading());

    try {
      final res = await OrganizationHttpClient.getOrganizationPosts(orgId);

      if (res.statusCode == 200) {
        final responseBody = jsonDecode(res.body);
        final posts =
            (responseBody as List).map((post) => Post.fromJson(post)).toList();

        emit(OrganizationPostsSuccess(posts));
        return posts;
      } else {
        emit(const OrganizationFailure(
            errMessage: "Something went wrong, try again!"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(const OrganizationFailure(
          errMessage: "Failed to get organization posts!"));
    }

    return [];
  }

  Future<List<Organization>>? getUserOrganizations(
      BuildContext context, int userId) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      emit(const UserOrganizationsLoading());

      try {
        final response = await UserHttpClient.getUserOrganizations(userId);

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          final organizations = <Organization>[];

          for (var org in responseBody) {
            organizations.add(Organization.fromJson(org));
          }

          emit(UserOrganizationsSuccess(organizations));
          return organizations;
        } else {
          emit(const OrganizationFailure(
              errMessage: "Something went wrong, try again!"));

          return [];
        }
      } catch (e) {
        print(e);
        emit(const OrganizationFailure(
            errMessage: "Failed to join organization!"));
        return [];
      }
    }
    return [];
  }

  Future<void> leaveOrganization(BuildContext context, int orgId) async {
    final userCubit = context.read<UserCubit>();
    final userId = userCubit.getCurrentUser()?.id;
    if (userCubit.state is UserLoaded) {
      emit(const LeaveOrganizationLoading());

      try {
        final response =
            await OrganizationHttpClient.removeMemberFromOrganization(
                orgId, userId!);

        if (response.statusCode == 200) {
          updateOrganizationsList(context);

          // get user organization
          final userOrganizationResponse =
              await UserHttpClient.getUserOrganizations(userId);
          if (userOrganizationResponse.statusCode == 200) {
            List<dynamic> userOrganizations =
                jsonDecode(userOrganizationResponse.body);
            if (userOrganizations.isNotEmpty) {
              // Assuming each organization object has an 'id' field
              int firstOrganizationId = userOrganizations[0]['id'];
              final prefs = await SharedPreferences.getInstance();
              await prefs.setInt('currentOrganizationId', firstOrganizationId);
              // set the current organization in the current organization cubit
              context
                  .read<CurrentOrganizationCubit>()
                  .loadCurrentOrganization();
            }
          } else {
            // Handle the case where fetching organizations failed
            print("Failed to fetch user organizations");
          }

          emit(const LeaveOrganizationSuccess());
        } else {
          emit(const OrganizationFailure(
              errMessage: "Something went wrong, try again!"));
        }
      } catch (e) {
        print(e);
        emit(const OrganizationFailure(
            errMessage: "Failed to leave organization!"));
      }
    }
  }
}
