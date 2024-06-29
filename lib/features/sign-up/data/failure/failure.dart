import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);

}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    switch(e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with api server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with api server');
      case DioExceptionType.badResponse:
        return ServerFailure('Response error');
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
}


// class NetworkFailure extends Failure {}