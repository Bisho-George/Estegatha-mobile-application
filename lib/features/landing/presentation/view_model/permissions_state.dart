class PermissionState{}
class PermissionStateInitial extends PermissionState{}
class PermissionStateFinished extends PermissionState{}
class PermissionStateError extends PermissionState{
  final String message;
  PermissionStateError({required this.message});
}