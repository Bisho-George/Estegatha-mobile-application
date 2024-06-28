import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/custom_http_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrganizationHttpClient {
  static String organizationBaseUrl =
      '${ConstantVariables.uri}/api/v1/organizations';
  static final CustomHttpClient _customHttpClient = CustomHttpClient();

  static Future<http.Response> customHttpRequest(String method, Uri url,
      {Map<String, String>? headers, dynamic body}) async {
    String accessToken = await _customHttpClient.getAccessToken();
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
      case 'DELETE':
        response = await http.delete(url, headers: headers);
        break;
      case 'PUT':
        response =
            await http.put(url, headers: headers, body: jsonEncode(body));
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
        case 'DELETE':
          response = await http.delete(url, headers: headers);
          break;
        case 'PUT':
          response =
              await http.put(url, headers: headers, body: jsonEncode(body));
          break;
      }
    }

    return response;
  }

  static Future<http.Response> createOrganization(
      String name, String? type) async {
    return customHttpRequest('POST', Uri.parse(organizationBaseUrl),
        body: {'name': name, 'type': type});
  }

  static Future<http.Response> joinOrganizationByCode(
      String organizationCode) async {
    return customHttpRequest(
        'POST', Uri.parse('$organizationBaseUrl/join/code/$organizationCode'));
  }

  static Future<http.Response> getOrganizationById(int orgId) async {
    return customHttpRequest('GET', Uri.parse('$organizationBaseUrl/$orgId'));
  }

  static Future<http.Response> getOrganizationMembers(int orgId) async {
    return customHttpRequest(
        'GET', Uri.parse('$organizationBaseUrl/members/$orgId'));
  }

  static Future<http.Response> getOrganizationPosts(int orgId) async {
    return customHttpRequest(
        'GET', Uri.parse('$organizationBaseUrl/posts/$orgId'));
  }

  static Future<http.Response> removeMemberFromOrganization(
      int orgId, int userId) async {
    return customHttpRequest('DELETE',
        Uri.parse('$organizationBaseUrl/$orgId/remove-member/$userId'));
  }

  static Future<http.Response> leaveOrganization(int orgId, int userId) async {
    return customHttpRequest(
        'POST', Uri.parse('$organizationBaseUrl/$orgId/leave/$userId'));
  }

  static Future<http.Response> deleteOrganization(int orgId) async {
    return customHttpRequest(
        'DELETE', Uri.parse('$organizationBaseUrl/$orgId'));
  }

  static Future<http.Response> changeMemberRole(
      int orgId, int userId, String newRole) async {
    return customHttpRequest(
        'PUT',
        Uri.parse(
            '$organizationBaseUrl/$orgId/update-role/$userId?role=$newRole'));
  }

  static Future<http.Response> updateOrganization(
      int orgId, String name, String type) async {
    return customHttpRequest(
        'PUT', Uri.parse('$organizationBaseUrl/update/$orgId'),
        body: {'name': name, 'type': type});
  }
}
