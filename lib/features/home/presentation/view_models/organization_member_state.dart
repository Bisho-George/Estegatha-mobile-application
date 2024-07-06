part of 'organization_member_cubit.dart';

@immutable
sealed class OrganizationMemberHomeState {}

final class OrganizationMemberHomeInitial extends OrganizationMemberHomeState {}

final class OrganizationMemberHomeLoading extends OrganizationMemberHomeState {}

final class OrganizationMemberHomeSuccess extends OrganizationMemberHomeState {
  final List<OrganizationMember> members;

  OrganizationMemberHomeSuccess(this.members);
}

final class OrganizationMemberHomeFailure extends OrganizationMemberHomeState {
  final String message;

  OrganizationMemberHomeFailure(this.message);
}