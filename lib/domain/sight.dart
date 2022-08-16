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
  sightTypes type;

  Sight(this.name, this.lat, this.lon, this.url, this.details, this.type);
}

enum sightTypes {coffeeShop, park, museum}
