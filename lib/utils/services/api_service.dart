import 'package:dio/dio.dart';
import 'package:estegatha/utils/constant/variables.dart';

import '../../core/data/api/dio_auth.dart';

class ApiService {
  late final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get('${ConstantVariables.uri}$endpoint');
    return response.data;
  }

  Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    isSignup = true,
  }) async {
    isSignup ? _dio = await DioAuth.getDio() : null;
    var response = await _dio.post(
      '${ConstantVariables.uri}/$endpoint',
      data: data,
      options: Options(headers: headers),
      queryParameters: queryParams,
    );
    return response;
  }
}
