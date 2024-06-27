import 'package:dio/dio.dart';

String successMessage = 'Phone number has been updated successfully';
String failedMessage = 'Failed to update phone number';
abstract class EditPhoneRepo {
  Future<String> editPhone(String phone);
}
class EditPhoneApi extends EditPhoneRepo {
  @override
  Future<String> editPhone(String phone) async {
    Dio dio = Dio();
    try{
/*      Response response = await dio.post('https://example.com/edit_phone', data: {'phone': phone});
      if(response.statusCode == 200) {
        return successMessage;
      }*/
      return successMessage;
    }
    catch(e){
      return failedMessage;
    }
    return failedMessage;
  }
}