// part of 'organization_cubit.dart';

import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
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

class OrganizationDetailSuccess extends OrganizationState {
  final Organization organization;
  final List<OrganizationMember>? members;
  final List<Post>? posts;

  const OrganizationDetailSuccess(this.organization, {this.members, this.posts})
      : super(organization);
}

class OrganizationSuccess extends OrganizationState {
  final List<OrganizationMember> members;
  final List<Post> posts;

  const OrganizationSuccess(
      {required this.members, required this.posts, Organization? organization})
      : super(organization);
}

class OrganizationLoading extends OrganizationState {
  const OrganizationLoading() : super(null);
}

class JoinOrganizationLoading extends OrganizationState {
  const JoinOrganizationLoading() : super(null);
}

class UserOrganizationsLoading extends OrganizationState {
  const UserOrganizationsLoading() : super(null);
}

class OrganizationMembersLoading extends OrganizationState {
  const OrganizationMembersLoading() : super(null);
}

class OrganizationFailure extends OrganizationState {
  final String errMessage;

  const OrganizationFailure({required this.errMessage}) : super(null);
}

class OrganizationMembersSuccess extends OrganizationState {
  final List<OrganizationMember> members;

  const OrganizationMembersSuccess(this.members) : super(null);
}

class OrganizationJoinSuccess extends OrganizationState {
  final Organization organization;
  const OrganizationJoinSuccess(
    this.organization,
  ) : super(organization);
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

class UserOrganizationsSuccess extends OrganizationState {
  final List<Organization> organizations;

  const UserOrganizationsSuccess(this.organizations) : super(null);
}

class CurrentOrganizationId extends OrganizationState {
  final int organizationId;

  const CurrentOrganizationId(this.organizationId) : super(null);
}

class LeaveOrganizationLoading extends OrganizationState {
  const LeaveOrganizationLoading() : super(null);
}

class LeaveOrganizationSuccess extends OrganizationState {
  const LeaveOrganizationSuccess() : super(null);
}

class ChangeMemberRoleLoading extends OrganizationState {
  const ChangeMemberRoleLoading() : super(null);
}

class ChangeMemberRoleSuccess extends OrganizationState {
  const ChangeMemberRoleSuccess() : super(null);
}

class RemoveMemberLoading extends OrganizationState {
  const RemoveMemberLoading() : super(null);
}

class RemoveMemberSuccess extends OrganizationState {
  final List<OrganizationMember> members;
  const RemoveMemberSuccess(
    this.members,
  ) : super(null);
}
