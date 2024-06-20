class CreatePinStatus{}
class CreatePinInitial extends CreatePinStatus{}
class CreatePinLoading extends CreatePinStatus{}
class CreatePinFailed extends CreatePinStatus{
  final String message;
  CreatePinFailed({required this.message});
}
class CreatePinSuccess extends CreatePinStatus{}