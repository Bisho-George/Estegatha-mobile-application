import 'dart:convert';
import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/custom_http_client.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:http/http.dart' as http;

class CatalogHttpClient {
  static String catalogBaseUrl =
      '${ConstantVariables.uri}/api/v1/emergency-catalog';
  static final CustomHttpClient _customHttpClient = CustomHttpClient();

  static Future<http.Response> customHttpRequest(String method, Uri url,
      {Map<String, String>? headers, dynamic body}) async {
    String accessToken = await HelperFunctions.getAccessToken();
    headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accessToken',
    }..addAll(headers ?? {});

    http.Response response;
    switch (method.toUpperCase()) {
      case 'POST':
        response =
            await http.post(url, headers: headers, body: jsonEncode(body));
        break;
      case 'GET':
        response = await http.get(url, headers: headers);
        break;
      default:
        throw Exception('HTTP method $method not supported');
    }

    if (response.statusCode == 404 || response.statusCode == 401) {
      accessToken = await _customHttpClient.renewAccessToken();
      headers['Authorization'] = 'Bearer $accessToken';

      switch (method.toUpperCase()) {
        case 'POST':
          response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          break;
        case 'GET':
          response = await http.get(url, headers: headers);
          break;
      }
    }

    return response;
  }

  static Future<http.Response> getCatalogBlogs() async {
    return customHttpRequest('GET', Uri.parse(catalogBaseUrl));
  }
}
