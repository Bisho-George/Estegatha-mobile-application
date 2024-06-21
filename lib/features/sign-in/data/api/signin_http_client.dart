import 'dart:convert';

import 'package:estegatha/utils/constant/variables.dart';

import 'package:http/http.dart' as http;

class SignInHttpClient {
  static String authBaseUrl = '${ConstantVariables.uri}/api/v1/auth';

  static Future<http.Response> login(
      String url, String email, String password) async {
    return await http.post(
      Uri.parse(authBaseUrl + url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  // get user by id
  static Future<http.Response> getUserById(int id) async {
    return await http.get(
      Uri.parse('$authBaseUrl/user/$id'),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
