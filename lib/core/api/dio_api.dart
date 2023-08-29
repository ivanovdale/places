import 'package:dio/dio.dart';
import 'package:places/core/api/dio_interceptor.dart';
import 'package:places/core/helpers/app_urls.dart';

/// Класс для работы с АПИ.
///
/// Позволяет создать http-клиента.
class DioApi {
  final Dio httpClient;

  DioApi() : httpClient = _createDio();

  static Dio _createDio() {
    const timeOut = Duration(milliseconds: 5000);

    final dio = Dio(BaseOptions(
      baseUrl: AppUrls.dioClientUrl,
      receiveTimeout: timeOut,
      connectTimeout: timeOut,
      sendTimeout: timeOut,
    ));

    dio.interceptors.addAll({
      DioInterceptor(dio),
    });

    return dio;
  }
}
