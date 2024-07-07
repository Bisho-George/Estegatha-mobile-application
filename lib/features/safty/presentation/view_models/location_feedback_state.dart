class LocationFeedbackState{}
class LocationFeedbackInitial extends LocationFeedbackState{}
class LocationFeedbackSuccess extends LocationFeedbackState{
  final String message;
  LocationFeedbackSuccess({required this.message});
}
class LocationFeedbackFailure extends LocationFeedbackState{
  final String message;
  LocationFeedbackFailure({required this.message});
}