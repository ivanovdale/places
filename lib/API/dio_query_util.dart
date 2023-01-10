import 'package:dio/dio.dart';
import 'package:places/API/dio_api.dart';
import 'package:places/data/repository/exceptions/network_exception.dart';

class DioQueryUtil {
  /// Выполняет http запрос с помощью Dio-клиента.
  /// Если была ошибка и её код 500 - выбрасывается [NetworkException].
  ///
  /// Принимает параметры:
  /// * [apiUtil] - http-клиент DIO;
  /// * [dioMethod] - метод http-запроса;
  /// * [uri] - запрашиваемый URI;
  /// * [data] - данные для POST метода.
  static Future<Response<String>> handleQuery(
    DioApi apiUtil, {
    required DioMethod dioMethod,
    required String uri,
    Object? data,
  }) async {
    Response<String> response;
    try {
      switch (dioMethod) {
        case DioMethod.get:
          response = await apiUtil.httpClient.get<String>(
            uri,
          );
          break;
        case DioMethod.post:
          response = await apiUtil.httpClient.post<String>(uri, data: data);
          break;
      }
    } on DioError catch (dioError) {
      final response = dioError.response;
      if (response?.statusCode == 500) {
        final queryName = '${apiUtil.httpClient.options.baseUrl}$uri';
        throw NetworkException(
          queryName,
          500,
          response?.statusMessage ?? '',
        );
      } else {
        rethrow;
      }
    }

    return response;
  }
}

/// Методы http клиента.
enum DioMethod {
  get,
  post,
}
