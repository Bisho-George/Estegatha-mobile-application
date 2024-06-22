class EditAccountState{}
class EditAccountInitialState extends EditAccountState{}
class EditAccountSuccessState extends EditAccountState{
  final String ?message;
  EditAccountSuccessState({this.message});
}
class EditAccountFailureState extends EditAccountState{
  final String error;
  EditAccountFailureState({required this.error});
}