import 'package:dio/dio.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/sos/domain/message_repo.dart';

class SmsMessageApi extends SmsMessageRepo{
  @override
  Future<void> sendMessage(String message, String phone) async{
    Dio dio = await DioAuth.getDio();
    dio.post('$baseUrl$messagesEndPoint', data: {
      'message' : message,
      'phone' : phone,
    });
  }
  
}