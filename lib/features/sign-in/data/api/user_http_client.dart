import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/custom_http_client.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:http/http.dart' as http;

class UserHttpClient {
  static String userBaseUrl = '${ConstantVariables.uri}/api/v1/users';
  static final CustomHttpClient _customHttpClient = CustomHttpClient();

  // Utilize the customHttpRequest method for making HTTP requests
  static Future<http.Response> customHttpRequest(String method, Uri url,
      {Map<String, String>? headers, dynamic body}) async {
    String accessToken = await HelperFunctions.getAccessToken();
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    }..addAll(headers ?? {});

    http.Response response;
    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(url, headers: headers);
        break;

      case 'POST':
        response = await http.post(url, headers: headers, body: body);
        break;
      default:
        throw Exception('HTTP method $method not supported');
    }

    if (response.statusCode == 404 || response.statusCode == 401) {
      accessToken = await _customHttpClient.renewAccessToken();
      headers['Authorization'] = 'Bearer $accessToken';

      response = await http.get(url, headers: headers);
    }

    return response;
  }

  static Future<http.Response> getUserOrganizations(int userId) async {
    return customHttpRequest('GET', Uri.parse('$userBaseUrl/organizations'));
  }

  static Future<http.Response> addUserDisease(String disease) async {
    return customHttpRequest(
        'POST', Uri.parse('$userBaseUrl/health-info/illness?illness=$disease'));
  }

  static Future<http.Response> addUserMedicine(String medicine) async {
    return customHttpRequest('POST',
        Uri.parse('$userBaseUrl/health-info/medicine?medicine=$medicine'));
  }

  static Future<http.Response> getUserHealthInfo() async {
    return customHttpRequest('GET', Uri.parse('$userBaseUrl/health-info'));
  }
}
