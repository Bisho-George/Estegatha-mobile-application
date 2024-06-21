import 'dart:convert';

import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Email is required";
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return "Invalid email";
    }

    return null;
  }

  static Future<String> getAccessToken() async {
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

  // static to get user object from shared preferences
  static Future<Member> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user == null) {
      throw Exception('User not found in SharedPreferences');
    }
    return jsonDecode(user);
  }
}
