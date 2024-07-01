import 'dart:convert';
import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/custom_http_client.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:http/http.dart' as http;

class SignInHttpClient {
  static String authBaseUrl = '${ConstantVariables.uri}/api/v1/auth';
  static final CustomHttpClient _customHttpClient = CustomHttpClient();

  static Future<http.Response> customHttpRequest(String method, Uri url,
      {Map<String, String>? headers, dynamic body}) async {
    String accessToken = await HelperFunctions.getAccessToken();
    headers = {
      'Content-Type': 'application/json',
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

  static Future<http.Response> login(String email, String password) async {
    return await http
        .post(
          Uri.parse('$authBaseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        )
        .timeout(const Duration(seconds: 5));
  }

  static Future<http.Response> getUserById(int id) async {
    return customHttpRequest('GET', Uri.parse('$authBaseUrl/user/$id'));
  }

  // static Future<http.Response> resetPasswordEmail(String email) async {
  //   return customHttpRequest(
  //       'POST', Uri.parse('$authBaseUrl/reset-password-link?email=$email'));
  // }

  static Future<http.Response> createResetToken(String email) async {
    final res = await http.post(
      Uri.parse('$authBaseUrl/create-reset-token?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );

    print("response: ${res.body}");
    print("status code: ${res.statusCode}");

    return res;
  }

  static Future<http.Response> sendResetToken(String email) async {
    final res = await http.post(
      Uri.parse('$authBaseUrl/send-reset-token?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );

    print("response: ${res.body}");
    print("status code: ${res.statusCode}");

    return res;
  }

  static Future<http.Response> resetPassword(
      String email, String newPassword, String token) async {
    final res = await http.post(
      Uri.parse('$authBaseUrl/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'email': email, 'newPassword': newPassword, 'token': token}),
    );

    print("response: ${res.body}");
    print("status code: ${res.statusCode}");

    return res;
  }

  static Future<http.Response> resendResetToken(String email) async {
    final res = await http.post(
      Uri.parse('$authBaseUrl/resend-reset-token?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );

    print("response: ${res.body}");
    print("status code: ${res.statusCode}");

    return res;
  }
}
