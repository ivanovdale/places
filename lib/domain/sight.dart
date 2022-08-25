/// Модель достопримечательности.
///
/// Имеет следующие поля:
/// * [name] - название достопримечательности;
/// * [lat] - географическая долгота точки;
/// * [lon] - географическая широта точки;
/// * [url] - путь до фотографии в интернете;
/// * [details] - подробное описание места;
/// * [type] - тип достопримечательности;
/// * [workTimeFrom] - время работы "с". Например, 09:00.
class Sight {
  String name;
  double lat;
  double lon;
  String url;
  String details;
  SightTypes type;
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
