// part of 'organization_cubit.dart';

import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/post.dart';
import 'package:flutter/material.dart';

@immutable
abstract class OrganizationState {
  final Organization? organization;

  const OrganizationState(this.organization);
}

class OrganizationInitial extends OrganizationState {
  const OrganizationInitial() : super(null);
}

// class OrganizationSuccess extends OrganizationState {
//   const OrganizationSuccess(Organization organization) : super(organization);
// }

class OrganizationCreationSuccess extends OrganizationState {
  final Organization organization;

  const OrganizationCreationSuccess(this.organization) : super(organization);
}

class OrganizationSuccess extends OrganizationState {
  final List<Member> members;
  final List<Post> posts;

  const OrganizationSuccess(
      {required this.members, required this.posts, Organization? organization})
      : super(organization);
}

class OrganizationLoading extends OrganizationState {
  const OrganizationLoading() : super(null);
}

class OrganizationFailure extends OrganizationState {
  final String errMessage;

  const OrganizationFailure({required this.errMessage}) : super(null);
}

class OrganizationMembersSuccess extends OrganizationState {
  final List<Member> members;

  OrganizationMembersSuccess(this.members) : super(null);
}

class OrganizationJoinSuccess extends OrganizationState {
  final Member member;

  OrganizationJoinSuccess(this.member) : super(null);
}

class PostSuccess extends OrganizationState {
  final Post post;

  const PostSuccess(this.post) : super(null);
}

class OrganizationPostsLoading extends OrganizationState {
  const OrganizationPostsLoading() : super(null);
}

class OrganizationPostsFailure extends OrganizationState {
  final String errMessage;

  const OrganizationPostsFailure({required this.errMessage}) : super(null);
}

class OrganizationPostsSuccess extends OrganizationState {
  final List<Post> posts;

  const OrganizationPostsSuccess(this.posts) : super(null);
}
