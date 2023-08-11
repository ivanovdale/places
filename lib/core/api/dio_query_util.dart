import 'package:dio/dio.dart';
import 'package:places/core/api/dio_api.dart';
import 'package:places/core/data/repository/exceptions/network_exception.dart';

class DioQueryUtil {
  /// Выполняет http запрос с помощью Dio-клиента.
  /// Если была ошибка и её код 500 - выбрасывается [NetworkException].
  ///
  /// Принимает параметры:
  /// * [apiUtil] - http-клиент DIO;
  /// * [requestType] - метод http-запроса;
  /// * [uri] - запрашиваемый URI;
  /// * [data] - данные для POST метода.
  static Future<Response<String>> handleQuery(
    DioApi apiUtil, {
    required RequestType requestType,
    required String uri,
    Object? data,
  }) async {
    Response<String> response;
    try {
      switch (requestType) {
        case RequestType.get:
          response = await apiUtil.httpClient.get<String>(
            uri,
          );
        case RequestType.post:
          response = await apiUtil.httpClient.post<String>(uri, data: data);
      }
    } on DioException catch (dioError, stackTrace) {
      final response = dioError.response;
      if (response?.statusCode == 500) {
        final queryName = '${apiUtil.httpClient.options.baseUrl}$uri';
        Error.throwWithStackTrace(
          NetworkException(
            queryName,
            500,
            response?.statusMessage ?? '',
          ),
          stackTrace,
        );
      } else {
        rethrow;
      }
    }

    return response;
  }
}

/// Методы http клиента.
enum RequestType {
  get,
  post,
}
