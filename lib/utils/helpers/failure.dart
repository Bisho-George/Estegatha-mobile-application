import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with api server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response?.statusCode, e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to api server cancelled');
      case DioExceptionType.unknown:
        return ServerFailure('Something went wrong, please try again');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet connection');
      default:
        return ServerFailure('Something went wrong');
    }
  }
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      print(response);
      return ServerFailure(response['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request was not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailure('there is a problem with server, please try later');
    } else {
      return ServerFailure('Something went wrong, please try again');
    }
  }
}