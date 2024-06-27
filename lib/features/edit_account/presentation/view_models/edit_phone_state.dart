class EditPhoneState{}
class EditPhoneInitialState extends EditPhoneState{}
class EditPhoneLoadingState extends EditPhoneState{}
class EditPhoneSuccessState extends EditPhoneState{}
class EditPhoneFailureState extends EditPhoneState{
  final String error;
  EditPhoneFailureState({required this.error});
}