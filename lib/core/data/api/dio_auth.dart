import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioAuth {
  static Future<Dio> getDio() async{
    final prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString(userKey) ?? '';
    final userJson = jsonDecode(userString);
    Member user = Member.fromJson(userJson);
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer ${user.accessToken}';
        return handler.next(options); //continue
      },
      onError: (error, handler) async{
        if (error.response?.statusCode == 401) {
          // If a 401 response is received, refresh the access token
          String newAccessToken = await refreshToken();

          // Update the request header with the new access token
          error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          // Repeat the request with the updated header
          return handler.resolve(await dio.fetch(error.requestOptions));
        }
        return handler.next(error);//continue
      },
    ));
    return dio;
  }

  static Future<String> refreshToken() async{
    final prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString(userKey) ?? '';
    final userJson = jsonDecode(userString);
    Member user = Member.fromJson(userJson);
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer ${user.refreshToken}';
        return handler.next(options); //continue
      },
      onError: (error, handler) async{

        return handler.next(error);//continue
      },
    ));
    Response response = await dio.post(baseUrl + refreshTokenEndPoint);
    String newAccessToken = response.data[accessTokenKey];
    userJson[tokensKey][accessTokenKey] = newAccessToken;
    prefs.setString(userKey, jsonEncode(userJson));
    return newAccessToken;
  }
}
