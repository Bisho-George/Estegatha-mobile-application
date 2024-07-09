import 'package:dio/dio.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';

import '../../../constants.dart';
import '../../../core/data/api/dio_auth.dart';

class RoleApi {
  Future<String> getRole(int orgId) async {
    Dio dio = await DioAuth.getDio();
    String? role;
    HelperFunctions.getUser().then((value) async {
      Response response = await dio
          .get('${baseUrl}/api/v1/organizations/${orgId}/role/${value.id}');
      role = response.data;
    });
    return role!;
  }
}
