import 'package:dio/dio.dart';

class DioAuth {
  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        String token = 'eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIyNDViNTE0My0wZTcyLTRiYzUtYjE1Yy0zMjQxMmJiZDkwNzMiLCJzdWIiOiJtaWRvbW9zdGFmYTUxNEBnbWFpbC5jb20iLCJpYXQiOjE3MTkwNzExMjYsImlzcyI6ImFwcC1TZXJ2aWNlIiwiZXhwIjoxNzE5MDcyOTI2LCJjcmVhdGVkIjoxNzE5MDcxMTI2NjIxfQ.wbr-w4t51hk2IsRavanUJZlsJFrY_tupekAKodeUibVcMGbCYvR-oB6f8Hr4HMJBquhSCWcQS9Ns36qAHlfEeA';
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options); //continue
      },
      onError: (error, handler) async{
/*        if (error.response?.statusCode == 401) {
          // If a 401 response is received, refresh the access token
          String newAccessToken = await refreshToken();

          // Update the request header with the new access token
          error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          // Repeat the request with the updated header
          return handler.resolve(await dio.fetch(error.requestOptions));
        }*/
        return handler.next(error);//continue
      },
    ));
    return dio;
  }
}
