import 'package:dio/dio.dart';
import 'package:estegatha/utils/constant/variables.dart';

class ApiService {
  final Dio _dio;

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
  }) async {
    var response = await _dio.post(
      '${ConstantVariables.uri}/$endpoint',
      data: data,
      options: Options(headers: headers),
      queryParameters: queryParams,
    );
    return response;
  }

}
