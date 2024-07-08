abstract class CancelSosRepo{
  Future<void> cancelSos(String pin);
  Future<void> sendFeedback(String text);
}