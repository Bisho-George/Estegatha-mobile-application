class AddContactState{}
class AddContactInitial extends AddContactState{}
class AddContactFailure extends AddContactState{
  AddContactFailure(this.message);
  String message;
}
class AddContactSuccess extends AddContactState{
  AddContactSuccess(this.message);
  String message;
}