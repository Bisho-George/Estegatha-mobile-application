class FitnessConnectState{}
class FitnessConnectInitial extends FitnessConnectState{}
class FitnessConnectSuccess extends FitnessConnectState{
  final dynamic result;
  FitnessConnectSuccess(this.result);
}
class FitnessConnectFailure extends FitnessConnectState{
  final String message;
  FitnessConnectFailure(this.message);
}