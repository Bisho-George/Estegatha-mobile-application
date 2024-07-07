class CancelSosState{}
class CancelSosInitial extends CancelSosState{}
class CancelSosSuccess extends CancelSosState{
  final String ?message;
  CancelSosSuccess({this.message});
}
class CancelSosFailure extends CancelSosState{
  final String ?message;
  CancelSosFailure({this.message});
}