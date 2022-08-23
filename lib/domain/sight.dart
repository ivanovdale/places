/// Модель достопримечательности.
///
/// Имеет следующие поля:
/// * [name] - название достопримечательности;
/// * [lat] - географическая долгота точки;
/// * [lon] - географическая широта точки;
/// * [url] - путь до фотографии в интернете;
/// * [details] - подробное описание места;
/// * [type] - тип достопримечательности;
/// * [workTimeFrom] - время работы "с".
class Sight {
  /// Название достопримечательности.
  String name;

  /// Координаты места. Долгота.
  double lat;

  /// Координаты места. Широта.
  double lon;

  /// Путь до фотографии в интернете.
  String url;

  /// Описание достопримечательности.
  String details;

  /// Тип достопримечательности.
  SightTypes type;

  /// Время работы "с". Например, 09:00.
  String workTimeFrom;

  Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
    required this.workTimeFrom,
  });
}

enum SightTypes { coffeeShop, park, museum }
