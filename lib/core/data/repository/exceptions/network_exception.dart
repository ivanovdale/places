/// Ошибка сетевого запроса.
class NetworkException implements Exception {
  final String queryName;
  final int errorCode;
  final String errorName;

  NetworkException(
    this.queryName,
    this.errorCode,
    this.errorName,
  );

  @override
  String toString() {
    return "В запросе '$queryName' возникла ошибка: $errorCode $errorName";
  }
}
