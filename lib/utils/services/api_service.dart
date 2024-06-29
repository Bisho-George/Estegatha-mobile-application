import 'package:dio/dio.dart';
import 'package:estegatha/utils/constant/variables.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get('${ConstantVariables.uri}$endpoint');
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endpoint,
      required Map<String, dynamic> data,
      Map<String, dynamic>? headers}) async {
    var response = await _dio.post(
      '${ConstantVariables.uri}/$endpoint',
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }
}
