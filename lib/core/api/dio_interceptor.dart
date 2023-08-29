import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:places/core/api/exceptions/bad_request_exception.dart';
import 'package:places/core/api/exceptions/conflict_exception.dart';
import 'package:places/core/api/exceptions/deadline_exceeded_exception.dart';
import 'package:places/core/api/exceptions/internal_server_error_exception.dart';
import 'package:places/core/api/exceptions/no_internet_connection_exception.dart';
import 'package:places/core/api/exceptions/not_found_exception.dart';
import 'package:places/core/api/exceptions/unauthorized_exception.dart';

/// Интерцептор для DIO.
///
/// Позволяет вывести в консоль полученные данные и также выводит ошибки, если они есть.
class DioInterceptor extends Interceptor {
  final Dio dio;
  final bool useLogger;

  DioInterceptor(
    this.dio, {
    this.useLogger = false,
  });

  @override
  Future<dynamic> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    logPrint('*** Api Response - Start ***');

    printKeyValue('URI', response.requestOptions.uri);
    printKeyValue('STATUS CODE', response.statusCode ?? '');
    printKeyValue('REDIRECT', response.isRedirect);
    logPrint('BODY:');
    printAll(response.data.toString());

    logPrint('*** Api Response - End ***');

    return handler.next(response);
  }

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logPrint('*** API Request - Start ***');

    printKeyValue('URI', options.uri);
    printKeyValue('METHOD', options.method);
    if (options.data != null) {
      logPrint('BODY:');
      printAll(options.data.toString());
    }

    logPrint('*** API Request - End ***');

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
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
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }

  void printKeyValue(String key, Object value) {
    logPrint('$key: $value');
  }

  void printAll(String message) {
    message.split('\n').forEach(logPrint);
  }

  void logPrint(String text) {
    if (useLogger) developer.log(text, name: 'place.dio');
  }
}
