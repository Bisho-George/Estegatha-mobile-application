import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:estegatha/features/organization/domain/api/organization_api.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/domain/models/post.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/user_organizations_cubit.dart'
    as userOrgCubit;
import 'package:estegatha/features/sign-in/data/api/user_http_client.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';
import '../../../../core/data/api/dio_auth.dart';
import 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  OrganizationCubit() : super(const OrganizationInitial());

  // ============= Create Organization =============
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

  // ============= update Organizations List =============
  Future<void> updateOrganizationsList(BuildContext context) async {
    final userId = BlocProvider.of<UserCubit>(context).getCurrentUser()?.id;
    if (userId != null) {
      context
          .read<userOrgCubit.UserOrganizationsCubit>()
          .getUserOrganizations(userId);
    }
  }

  // ============= Join Organization =============
  Future<void> joinOrganizationByCode(BuildContext context, String code) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      emit(const JoinOrganizationLoading());

      try {
        final response =
            await OrganizationHttpClient.joinOrganizationByCode(code);
        FirebaseMessaging.instance.getToken().then((value) async{
          Dio dio = await DioAuth.getDio();
          dio.post('${baseUrl}api/v1/notification/join',
              queryParameters: {
                // pass org id
                'organizationId': Organization.fromJson(jsonDecode(response.body)).id,
                'token': value,
              }
          );
          // send notification to the organization members
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

  // ============= Get Organization By Id =============
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

  // ============= Get Organization Members =============
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

  // ============= Get Organization Posts =============
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

  // ============= Get user organizations =============
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

  // ============= Leave Organization =============
  Future<bool> leaveOrganization(BuildContext context, int orgId) async {
    final userCubit = context.read<UserCubit>();
    final userId = userCubit.getCurrentUser()?.id;
    if (userCubit.state is UserLoaded) {
      try {
        final response =
            await OrganizationHttpClient.leaveOrganization(orgId, userId!);
        print(
            "Leave organization response status code: ${response.statusCode}");
        print("Leave organization response: ${response.body}");

        if (response.statusCode == 200) {
          updateOrganizationsList(context);

          final userOrganizationResponse =
              await UserHttpClient.getUserOrganizations(userId);

          if (userOrganizationResponse.statusCode == 200) {
            List<dynamic> userOrganizations =
                jsonDecode(userOrganizationResponse.body);
            if (userOrganizations.isNotEmpty) {
              int firstOrganizationId = userOrganizations[0]['id'];
              print("New current organization id: $firstOrganizationId");
              context
                  .read<CurrentOrganizationCubit>()
                  .setCurrentOrganization(firstOrganizationId);
            }
            return true;
          } else {
            print("Failed to fetch user organizations");
          }

          emit(const LeaveOrganizationSuccess());
        } else if (jsonDecode(response.body)['success'] == false) {
          final responseData = jsonDecode(response.body);
          emit(LeaveOrganizationFailure(errMessage: responseData['message']));
          await getOrganizationById(orgId);
          return false;
        } else {
          emit(const LeaveOrganizationFailure(
              errMessage: "Something went wrong, try again!"));
        }
        await getOrganizationById(orgId);
        return false;
      } catch (e) {
        print(e);
        emit(const LeaveOrganizationFailure(
            errMessage: "Failed to leave organization!"));
      }
    }
    return false;
  }

  Future<void> removeMemberFromOrganization(
      BuildContext context, int orgId, int userId) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      emit(const RemoveMemberLoading());

      try {
        // Fetch current members to check the count
        final List<OrganizationMember> currentMembers =
            await getOrganizationMembers(orgId);

        if (currentMembers.length > 1) {
          // Proceed with member removal if more than one member exists
          final response =
              await OrganizationHttpClient.removeMemberFromOrganization(
                  orgId, userId);

          if (response.statusCode == 200) {
            final List<OrganizationMember> newMembers =
                await getOrganizationMembers(orgId);
            print("New Members length: ${newMembers.length}");
            emit(RemoveMemberSuccess(newMembers));
            await getOrganizationById(orgId);
          } else {
            emit(const OrganizationFailure(
                errMessage: "Something went wrong, try again!"));
          }
        } else {
          // Show dialog if only one member is left
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Delete Organization"),
                content: const Text(
                    "Deleting this member will delete the entire organization. Are you sure you want to proceed?"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: const Text("Delete"),
                    onPressed: () {
                      OrganizationHttpClient.deleteOrganization(orgId);
                      HelperFunctions.showSnackBar(
                          context, "Organization deleted successfully!");
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print(e);
        emit(const OrganizationFailure(
            errMessage: "Failed to remove member from organization!"));
      }
    }
  }

  Future<bool> changeMemberRole(
      BuildContext context, int orgId, int userId, String newRole) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      emit(const ChangeMemberRoleLoading());

      try {
        // Fetch current organization members
        final members = await getOrganizationMembers(orgId);

        // Check if there's at least one member with a role of 'owner' or 'admin'
        bool hasRequiredRole = members.any((member) =>
            (member.role == 'OWNER' || member.role == 'ADMIN') &&
            member.userId != userId);

        print("hasRequiredRole: $hasRequiredRole");

        // If trying to change the role of an 'owner' or 'admin', ensure another exists
        if (!hasRequiredRole && (newRole != 'OWNER' && newRole != 'ADMIN')) {
          HelperFunctions.showSnackBar(
              context, "Must have at least one 'owner' or 'admin'");
          await getOrganizationById(orgId);
          return false;
        }

        // Proceed with role change if condition is met
        final response = await OrganizationHttpClient.changeMemberRole(
            orgId, userId, newRole);

        if (response.statusCode == 200) {
          emit(const ChangeMemberRoleSuccess());
          await getOrganizationById(orgId);
          return true;
        } else {
          emit(const OrganizationFailure(
              errMessage: "Something went wrong, try again!"));
        }
      } catch (e) {
        print(e);
        emit(
          const OrganizationFailure(
              errMessage: "Failed to change member role!"),
        );
      }
    }
    return false;
  }

  Future<Organization> updateOrganization(BuildContext context, int orgId,
      Organization organization, String? name, String? type) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      emit(const UpdateOrganizationLoading());

      final updatedName = name ?? organization.name;
      final updatedType = type ?? organization.type;

      try {
        final response = await OrganizationHttpClient.updateOrganization(
            orgId, updatedName!, updatedType!);

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          final updatedOrganization = Organization.fromJson(responseBody);

          emit(UpdateOrganizationSuccess(updatedOrganization));

          await updateOrganizationsList(context);
          await getOrganizationById(orgId);
          return updatedOrganization;
        } else {
          emit(const OrganizationFailure(
              errMessage: "Something went wrong, try again!"));
        }
      } catch (e) {
        print(e);
        emit(const OrganizationFailure(
            errMessage: "Failed to update organization!"));
      }
    }
    return Organization();
  }
}
