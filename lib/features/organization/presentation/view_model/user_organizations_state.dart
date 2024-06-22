// user_organizations_state.dart

part of 'user_organizations_cubit.dart';

abstract class UserOrganizationsState extends Equatable {
  const UserOrganizationsState();

  @override
  List<Object> get props => [];
}

class UserOrganizationsInitial extends UserOrganizationsState {}

class UserOrganizationsLoading extends UserOrganizationsState {}

class UserOrganizationsSuccess extends UserOrganizationsState {
  final List<Organization> organizations;

  const UserOrganizationsSuccess(this.organizations);

  @override
  List<Object> get props => [organizations];
}

class UserOrganizationsFailure extends UserOrganizationsState {
  final String errorMessage;

  const UserOrganizationsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
