class ContactState{}
class ContactInitialState extends ContactState{}
class ContactLoadingState extends ContactState{}
class ContactSuccessState extends ContactState{}
class ContactFailureState extends ContactState{
  String message;
  ContactFailureState(this.message);
}
