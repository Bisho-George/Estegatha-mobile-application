class FitnessConnectState{}
class FitnessConnectInitial extends FitnessConnectState{}
class FitnessConnectSuccess extends FitnessConnectState{
  final String message;
  FitnessConnectSuccess(this.message);
}
class FitnessConnectFailure extends FitnessConnectState{
  final String message;
  FitnessConnectFailure(this.message);
}