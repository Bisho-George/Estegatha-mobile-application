import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:estegatha/utils/constant/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CustomHttpClient {
  static final CustomHttpClient _instance = CustomHttpClient._internal();

  factory CustomHttpClient() {
    return _instance;
  }

  CustomHttpClient._internal();

  Future<String> getAccessToken() async {
    return await HelperFunctions.getAccessToken();
  }

  Future getRefreshToken() async {
    return await HelperFunctions.getRefreshToken();
  }

  Future<String> renewAccessToken() async {
    print("Renewing access token ...");
    final refreshToken = await getRefreshToken();
    print("Refresh token: $refreshToken");
    final response = await http.post(
      Uri.parse('${ConstantVariables.uri}/api/v1/auth/renew-access-token'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $refreshToken",
      },
    );

    print("renew access token response: ${response.body}");
    print("renew access token status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['accessToken'];
      // Store the new access token in the shared preferences instead of the old one
      final pref = await SharedPreferences.getInstance();
      final user = pref.getString('user');

      final userJson = jsonDecode(user!);
      userJson['tokens']['accessToken'] = newAccessToken;
      pref.setString('user', jsonEncode(userJson));

      print("User object after updating access token: $userJson");

      return newAccessToken;
    } else {
      throw Exception('Failed to renew access token');
    }
  }
}
