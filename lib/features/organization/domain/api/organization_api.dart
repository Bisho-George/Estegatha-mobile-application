import 'dart:convert';

import 'package:estegatha/utils/constant/variables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrganizationHttpClient {
  static String organizationBaseUrl =
      '${ConstantVariables.uri}/api/v1/organizations';

  static Future<String> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user == null) {
      throw Exception('User not found in SharedPreferences');
    }
    final userJson = jsonDecode(user);
    final accessToken = userJson['tokens']['accessToken'];
    if (accessToken == null) {
      throw Exception('Access token is null');
    }
    return accessToken;
  }

  static Future<http.Response> createOrganization(
      String name, String? type) async {
    final accessToken = await _getAccessToken();

    final res = await http.post(
      Uri.parse(organizationBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({'name': name, 'type': type}),
      // body: jsonEncode(requestBody),
    );

    return res;
  }

  static Future<http.Response> joinOrganizationByCode(
      String organizationCode) async {
    final accessToken = await _getAccessToken();

    final res = await http.post(
      Uri.parse('$organizationBaseUrl/join/code/$organizationCode'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken",
      },
    );

    return res;
  }

  static Future<http.Response> getOrganizationById(int orgId) async {
    final accessToken = await _getAccessToken();
    final res = await http.get(
      Uri.parse('$organizationBaseUrl/$orgId'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken",
      },
    );

    print("OrganizationHttpClient.getOrganizationById: ${res.body}");

    return res;
  }

  static Future<http.Response> getOrganizationMembers(int orgId) async {
    final accessToken = await _getAccessToken();

    final res = await http.get(
      Uri.parse('$organizationBaseUrl/members/$orgId'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken",
      },
    );

    if (res.statusCode == 401) {
      // call  the refresh token to get the new access token
    }

    print("Status code: ${res.statusCode}");
    return res;
  }

  static Future<http.Response> getOrganizationPosts(int orgId) async {
    final accessToken = await _getAccessToken();
    final res = await http.get(
      Uri.parse('$organizationBaseUrl/posts/$orgId'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken",
      },
    );

    print("OrganizationHttpClient.getOrganizationPosts: ${res.body}");

    return res;
  }

  static Future<http.Response> removeMemberFromOrganization(
      int orgId, int userId) async {
    final accessToken = await _getAccessToken();
    final res = await http.delete(
      Uri.parse('$organizationBaseUrl/$orgId/remove-member/$userId'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken",
      },
    );

    print("OrganizationHttpClient.removeUserFromOrganization: ${res.body}");

    return res;
  }
}
