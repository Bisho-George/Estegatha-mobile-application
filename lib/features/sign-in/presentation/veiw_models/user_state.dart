part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFailure extends UserState {
  final String errMessage;

  const UserFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class UserLoaded extends UserState {
  final Member user;

  const UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserSuccess extends UserState {
  final Member user;

  const UserSuccess(this.user);

  @override
  List<Object> get props => [user];
}
