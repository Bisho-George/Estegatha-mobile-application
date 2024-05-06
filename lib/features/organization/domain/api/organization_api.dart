import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const uri = kIsWeb ? 'http://127.0.0.1:8080' : 'http://10.0.2.2:8080';

class OrganizationHttpClient {
  static String organizationBaseUrl = '$uri/organization';
  static String membersBaseUrl = '$uri/members';
  static String postsBaseUrl = '$uri/posts';
  static Future<http.Response> createOrganization(
      String url, Map<String, dynamic> body, int userId) async {
    // Serialize the body to JSON
    String jsonBody = jsonEncode(body);
    return await http.post(Uri.parse('$organizationBaseUrl$url?userId=$userId'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
        });
  }

  // New User login
  static Future<http.Response> fetchMembers(String url) async {
    return await http.get(Uri.parse(membersBaseUrl + url), headers: {
      'Content-Type': "application/json",
    });
  }

  static Future<http.Response> getOrganization(int id) async {
    return await http.get(
      Uri.parse('$organizationBaseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );
  }

  // get organization by code
  static Future<http.Response> getOrganizationByCode(String code) async {
    return await http.get(
      Uri.parse('$organizationBaseUrl/code/$code'),
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<http.Response> getMembersInOrganization(int id) async {
    return await http.get(
      Uri.parse('$organizationBaseUrl/$id/members'),
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<http.Response> joinOrganizationByCode(
      String organizationCode, int userId) async {
    return await http.post(
      Uri.parse(
          '$organizationBaseUrl/join?organizationCode=$organizationCode&userId=$userId'),
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<http.Response> addPost(
      String title, String content, int organizationId) async {
    return await http.post(
      Uri.parse(postsBaseUrl + '/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'content': content,
        'organizationId': organizationId,
      }),
    );
  }

  static Future<http.Response> getPostsByOrganizationId(
      int organizationId) async {
    return await http.get(
      Uri.parse('$organizationBaseUrl/$organizationId/posts'),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
