import 'package:equatable/equatable.dart';

abstract class ChangeRoleState extends Equatable {
  const ChangeRoleState();

  @override
  List<Object> get props => [];
}

class ChangeRoleInitial extends ChangeRoleState {}

class ChangeRoleLoading extends ChangeRoleState {}

class ChangeRoleSuccess extends ChangeRoleState {}

class ChangeRoleFailure extends ChangeRoleState {
  final String errorMessage;

  const ChangeRoleFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
