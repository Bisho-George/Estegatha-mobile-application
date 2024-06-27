import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const uri = kIsWeb ? 'http://127.0.0.1:8080' : 'http://10.0.2.2:8080';

class LoginHttpClient {
  static String authBaseUrl = '$uri/auth';
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
