import 'package:equatable/equatable.dart';

class CurrentOrganizationState extends Equatable {
  final int? organizationId;

  const CurrentOrganizationState({this.organizationId});

  @override
  List<Object?> get props => [organizationId];
}

class CurrentOrganizationInitial extends CurrentOrganizationState {
  const CurrentOrganizationInitial() : super();
}

class CurrentOrganizationUpdated extends CurrentOrganizationState {
  final int organizationId;
  const CurrentOrganizationUpdated({required this.organizationId})
      : super(organizationId: 0);
}
