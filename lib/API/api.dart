import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:places/helpers/app_urls.dart';

/// Класс для работы с АПИ.
///
/// Позволяет создать http-клиента.
class Api {
  static final _singleton = Api._internal();
  final dio = createDio();

  factory Api() => _singleton;

  Api._internal();

  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: AppUrls.dioClientUrl,
      receiveTimeout: 5000, // 15 seconds
      connectTimeout: 5000,
      sendTimeout: 5000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });

    return dio;
  }
}

/// Интерцептор для DIO.
///
/// Позволяет вывести в консоль полученные данные и также выводит ошибки, если они есть.
class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    logPrint('*** Api Response - Start ***');

    printKeyValue('URI', response.requestOptions.uri);
    printKeyValue('STATUS CODE', response.statusCode ?? '');
    printKeyValue('REDIRECT', response.isRedirect ?? false);
    logPrint('BODY:');
    printAll((response.data ?? '') as String);

    logPrint('*** Api Response - End ***');

    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }

  void printKeyValue(String key, Object value) {
    logPrint('$key: $value');
  }

  void printAll(String message) {
    message.toString().split('\n').forEach(logPrint);
  }

  void logPrint(String text) {
    debugPrint(text);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
