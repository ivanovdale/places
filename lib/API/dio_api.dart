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
