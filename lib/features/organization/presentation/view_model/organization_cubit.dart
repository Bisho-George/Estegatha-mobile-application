import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:estegatha/features/organization/domain/api/organization_api.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/post.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  OrganizationCubit() : super(OrganizationInitial());

  final httpclient = HttpClient();

  Future<void> createOrganization(BuildContext context,
      {required String name}) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      final userId = (userCubit.state as UserLoaded).user.id;
      emit(const OrganizationLoading());

      try {
        // Generate a random 6-digit code
        final code = _generateRandomCode();

        final response = await OrganizationHttpClient.createOrganization(
            '/create',
            {
              'name': name,
              'code': code,
              'members': [userId]
            },
            userId);

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          final organization = Organization(
            id: responseBody['organizationId'],
            name: responseBody['name'].toString(),
            code: responseBody['code'].toString(),
            memberIds: List<int>.from(responseBody['memberIds'].map((x) => x)),
          );

          // await DatabaseHelper.instance.insert({
          //   DatabaseHelper.columnName: name,
          //   DatabaseHelper.columnCode: code,
          // });

          final user = (userCubit.state as UserLoaded).user;
          final updatedOrganizationIds =
              List<int>.from(user.organizationIds ?? []);
          updatedOrganizationIds.add(organization.id);

          final updatedUser = Member(
            id: user.id,
            name: user.name,
            email: user.email,
            password: user.password,
            organizationIds: updatedOrganizationIds,
          );

          userCubit.setUser(updatedUser);

          // Save to db

          emit(OrganizationCreationSuccess(organization));
        } else {
          emit(const OrganizationFailure(
              errMessage: "Failed to create organization!"));
        }
      } catch (e) {
        print(e); // Add this line
        emit(const OrganizationFailure(
            errMessage: "Failed to create organization!"));
      }
    } else {
      emit(const OrganizationFailure(
          errMessage: "No user loaded! Cannot create organization."));
    }
  }

  Future<Organization?> getOrganizationDetailsById(int id) async {
    emit(const OrganizationLoading());

    try {
      final response = await OrganizationHttpClient.getOrganization(id);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final organization = Organization(
          id: responseBody['organizationId'],
          name: responseBody['name'].toString(),
          code: responseBody['code'].toString(),
          memberIds: List<int>.from(responseBody['memberIds'].map((x) => x)),
        );

        emit(OrganizationSuccess(
          members: const [],
          posts: const [],
          organization: organization,
        ));
        return organization;
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        emit(const OrganizationFailure(
            errMessage: "Failed to get organization details!"));
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      emit(const OrganizationFailure(
          errMessage: "Failed to get organization details!"));
      return null;
    }
  }

  // get organization by code
  Future<Organization?> getOrganizationByCode(String code) async {
    emit(const OrganizationLoading());

    try {
      final response = await OrganizationHttpClient.getOrganizationByCode(code);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final organization = Organization(
          id: responseBody['organizationId'],
          name: responseBody['name'].toString(),
          code: responseBody['code'].toString(),
          memberIds: List<int>.from(responseBody['memberIds'].map((x) => x)),
        );

        emit(OrganizationSuccess(
          members: const [],
          posts: const [],
          organization: organization,
        ));
        return organization;
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        emit(const OrganizationFailure(
            errMessage: "Failed to get organization by code!"));
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      emit(const OrganizationFailure(
          errMessage: "Failed to get organization by code!"));
      return null;
    }
  }

  String _generateRandomCode() {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final _rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        6,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );
  }

  Future<List<Member>?> getMembersInOrganization(
    int id,
  ) async {
    emit(const OrganizationLoading());

    try {
      final response =
          await OrganizationHttpClient.getMembersInOrganization(id);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final members = (responseBody as List)
            .map((member) => Member.fromJson(member))
            .toList();
        emit(OrganizationMembersSuccess(members));
        return members;
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        emit(const OrganizationFailure(
            errMessage: "Failed to get members in organization!"));
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      emit(const OrganizationFailure(
          errMessage: "Failed to get members in organization!"));
      return null;
    }
  }

  Future<void> joinOrganization(BuildContext context, String code) async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserLoaded) {
      final userId = (userCubit.state as UserLoaded).user.id;
      emit(const OrganizationLoading());

      try {
        print('Code: $code');
        print('Member ID: $userId');
        final response =
            await OrganizationHttpClient.joinOrganizationByCode(code, userId);

        // Print the status code and body
        print('Status code: ${response.statusCode}');
        print('Body: ${response.body}');

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          final member = Member.fromJson(responseBody);

          print("Member: $member");

          userCubit.setUser(member);

          emit(OrganizationJoinSuccess(member));
        } else {
          emit(const OrganizationFailure(
              errMessage: "Failed to join organization!"));
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

  Future<void> addPost(String title, String content, int organizationId) async {
    emit(const OrganizationLoading());

    try {
      final response =
          await OrganizationHttpClient.addPost(title, content, organizationId);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final post = Post.fromJson(responseBody);

        emit(PostSuccess(post));
      } else {
        emit(const OrganizationFailure(errMessage: "Failed to add post!"));
      }
    } catch (e) {
      print(e);
      emit(const OrganizationFailure(errMessage: "Failed to add post!"));
    }
  }

  Future<List<Post>> getPostsByOrganizationId(int organizationId) async {
    emit(const OrganizationPostsLoading());

    try {
      final response =
          await OrganizationHttpClient.getPostsByOrganizationId(organizationId);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body) as List;
        // print('Response body after decode: $responseBody');
        final posts = responseBody.map((item) => Post.fromJson(item)).toList();

        // print("Posts: $posts");

        emit(OrganizationPostsSuccess(posts));
        return posts;
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        emit(
          const OrganizationPostsFailure(
              errMessage: "Failed to get posts by organization ID!"),
        );
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      emit(const OrganizationPostsFailure(
          errMessage: "Failed to get posts by organization ID!"));
      return [];
    }
  }

  Future<void> getOrganizationData(int organizationId) async {
    emit(OrganizationLoading());

    try {
      List<Member>? members = await getMembersInOrganization(organizationId);
      List<Post> posts = await getPostsByOrganizationId(organizationId);

      emit(OrganizationSuccess(members: members ?? [], posts: posts));
    } catch (e) {
      emit(OrganizationFailure(errMessage: e.toString()));
    }
  }
}
