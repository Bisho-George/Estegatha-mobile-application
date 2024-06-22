import 'package:dio/dio.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/utils/constant/strings.dart';

import '../../domain/repositories/edit_account_repo.dart';

class EditAccountApi extends EditAccountRepo{
  @override
  Future<int> editPassword(String oldPassword, String newPassword) async{
    Dio dio = DioAuth.getDio();
    Response response = await dio.put(baseUrl + editPasswordEndPoint, data: {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    }).catchError((e) {
      return e;
    });
    if(response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Future<int> editPhone(String phone) async{
    if(phone.isEmpty) {
      return 0;
    }
    Dio dio = DioAuth.getDio();
    Response response = await dio.put('$baseUrl$editPhoneEndPoint/$phone').catchError((e){
      return e;
    });
    if(response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }

}