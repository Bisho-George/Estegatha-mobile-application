abstract class LocationFeedbackRepo{
  Future<void> sendFeedback(String feedback, double lat, double lng);
  Future<bool> isAllowed();
}