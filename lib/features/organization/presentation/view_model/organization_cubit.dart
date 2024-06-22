import 'dart:convert';
import 'package:estegatha/features/organization/domain/api/organization_api.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/domain/models/post.dart';
import 'package:estegatha/features/sign-in/data/api/user_http_client.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  OrganizationCubit() : super(const OrganizationInitial());

  Future<void> createOrganization(BuildContext context,
      {required String name, String? type}) async {
    final userCubit = context.read<UserCubit>();

    print("User state: ${userCubit.state}");
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
}
