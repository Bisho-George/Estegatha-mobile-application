abstract class SmsMessageRepo{
  Future<void> sendMessage(String message, String phone);
}