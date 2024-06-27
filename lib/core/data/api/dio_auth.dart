import 'package:dio/dio.dart';

class DioAuth {
  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        String token = 'eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI4YmUzYzI3ZC04NjQzLTQ5M2MtOTg0Mi1mYWE0MzcwMzc2NzQiLCJzdWIiOiJtaWRvbW9zdGFmYTUxNEBnbWFpbC5jb20iLCJpYXQiOjE3MTg4ODczNzksImlzcyI6ImFwcC1TZXJ2aWNlIiwiZXhwIjoxNzE4ODg5MTc5LCJjcmVhdGVkIjoxNzE4ODg3Mzc5NTI5fQ.NYDYOsdKb-pGIaaiwtynA20lReCRE6Lrd3yViQo0PuEL_McVttUPMARFxVFIS7CKnU633-WOnMbPYq_p0ISUYQ';
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
