part of 'user_health_cubit.dart';

abstract class UserHealthState extends Equatable {
  const UserHealthState();

  @override
  List<Object> get props => [];
}

class UserHealthInitial extends UserHealthState {}

class AddUserDiseaseLoading extends UserHealthState {}

class AddUserDiseaseSuccess extends UserHealthState {}

class AddUserDiseaseFailure extends UserHealthState {
  final String errMessage;

  const AddUserDiseaseFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class AddUserMedicineLoading extends UserHealthState {}

class AddUserMedicineSuccess extends UserHealthState {}

class AddUserMedicineFailure extends UserHealthState {
  final String errMessage;

  const AddUserMedicineFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class UserHealthInfoLoading extends UserHealthState {}

class UserHealthInfoFailure extends UserHealthState {
  final String errMessage;

  const UserHealthInfoFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class UserHealthInfoLoaded extends UserHealthState {
  final UserHealthInfo userHealthInfo;

  const UserHealthInfoLoaded(this.userHealthInfo);

  @override
  List<Object> get props => [userHealthInfo];
}

class DeleteUserDiseaseLoading extends UserHealthState {}

class DeleteUserDiseaseSuccess extends UserHealthState {}

class DeleteUserDiseaseFailure extends UserHealthState {
  final String errMessage;

  const DeleteUserDiseaseFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class DeleteUserMedicineLoading extends UserHealthState {}

class DeleteUserMedicineSuccess extends UserHealthState {}

class DeleteUserMedicineFailure extends UserHealthState {
  final String errMessage;

  const DeleteUserMedicineFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
