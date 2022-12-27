import 'package:dio/dio.dart';
import 'package:places/API/dio_interceptor.dart';
import 'package:places/helpers/app_urls.dart';

/// Класс для работы с АПИ.
///
/// Позволяет создать http-клиента.
class DioApi {
  static final DioApi _singleton = DioApi._internal();

  Dio get httpClient => createDio();

  factory DioApi() => _singleton;

  DioApi._internal();

  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: AppUrls.dioClientUrl,
      receiveTimeout: 5000, // 15 seconds
      connectTimeout: 5000,
      sendTimeout: 5000,
    ));

    dio.interceptors.addAll({
      DioInterceptor(dio),
    });

    return dio;
  }
}
