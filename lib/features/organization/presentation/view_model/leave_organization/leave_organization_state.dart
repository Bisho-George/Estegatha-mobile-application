import 'package:equatable/equatable.dart';

abstract class LeaveOrganizationState extends Equatable {
  const LeaveOrganizationState();

  @override
  List<Object> get props => [];
}

class LeaveOrganizationInitial extends LeaveOrganizationState {}

class LeaveOrganizationLoading extends LeaveOrganizationState {}

class LeaveOrganizationSuccess extends LeaveOrganizationState {}

class LeaveOrganizationFailure extends LeaveOrganizationState {
  final String errorMessage;

  const LeaveOrganizationFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
