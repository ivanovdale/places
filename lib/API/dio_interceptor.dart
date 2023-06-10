import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:places/API/exceptions/bad_request_exception.dart';
import 'package:places/API/exceptions/conflict_exception.dart';
import 'package:places/API/exceptions/deadline_exceeded_exception.dart';
import 'package:places/API/exceptions/internal_server_error_exception.dart';
import 'package:places/API/exceptions/no_internet_connection_exception.dart';
import 'package:places/API/exceptions/not_found_exception.dart';
import 'package:places/API/exceptions/unauthorized_exception.dart';

/// Интерцептор для DIO.
///
/// Позволяет вывести в консоль полученные данные и также выводит ошибки, если они есть.
class DioInterceptor extends Interceptor {
  final Dio dio;

  DioInterceptor(this.dio);

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    logPrint('*** Api Response - Start ***');

    printKeyValue('URI', response.requestOptions.uri);
    printKeyValue('STATUS CODE', response.statusCode ?? '');
    printKeyValue('REDIRECT', response.isRedirect);
    logPrint('BODY:');
    printAll(response.data as String);

    logPrint('*** Api Response - End ***');

    return handler.next(response);
  }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logPrint('*** API Request - Start ***');

    printKeyValue('URI', options.uri);
    printKeyValue('METHOD', options.method);
    if (options.data != null) {
      logPrint('BODY:');
      printAll(options.data as String);
    }

    logPrint('*** API Request - End ***');

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.badResponse:
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
      case DioErrorType.badCertificate:
      case DioErrorType.connectionError:
      case DioErrorType.unknown:
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
    developer.log(text, name: 'place.dio');
  }
}
