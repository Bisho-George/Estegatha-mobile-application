class EditPasswordState{}
class EditPasswordInitial extends EditPasswordState{}
class EditPasswordSuccess extends EditPasswordState{
  final String message;
  EditPasswordSuccess({required this.message});
}
class EditPasswordFailure extends EditPasswordState{
  final String message;
  EditPasswordFailure({required this.message});
}