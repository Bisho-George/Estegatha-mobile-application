part of 'current_organization_cubit.dart';

@immutable
sealed class CurrentOrganizationState {}

final class CurrentOrganizationInitial extends CurrentOrganizationState {}

final class CurrentOrganizationLoaded extends CurrentOrganizationState {
  final Organization organization;

  CurrentOrganizationLoaded(this.organization);
}
