class FitnessDataState{}
class FitnessDataInitial extends FitnessDataState{}
class FitnessDataFailure extends FitnessDataState{
  final String message;
  FitnessDataFailure(this.message);
}
class FitnessDataSuccess extends FitnessDataState{
  final String message;
  FitnessDataSuccess(this.message);
}