/// Модель данных с параметрами фильтра.
///
/// Все поля не обязательные, но параметры "lat", "lat" и "radius" зависят друг от друга,
/// поэтому если указан один из них, то остальные два становятся обязательными.
class PlacesFilterRequestDto {
  /// Широта
  final double? lat;

  /// Долгота
  final double? lng;

  /// Радиус поиска места
  final double? radius;

  /// Список типов мест
  final List<String>? typeFilter;

  /// Имя места
  final String? nameFilter;

  PlacesFilterRequestDto({
    this.lat,
    this.lng,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  });

  Map<String, Object> toJson() {
    final result = <String, Object>{};

    // Если все параметры широты, долготы и радиуса поиска заполнены, то добавим их в мапу.
    if (_isLatitudeFilled() && _isLongitudeFilled() && _isRadiusFilled()) {
      result
        ..putIfAbsent('lat', () => lat as double)
        ..putIfAbsent('lng', () => lng as double)
        ..putIfAbsent('radius', () => radius as double);
    }

    if (typeFilter != null && typeFilter!.isNotEmpty) {
      result.putIfAbsent('typeFilter', () => typeFilter as List<String>);
    }

    if (nameFilter != null && nameFilter!.isNotEmpty) {
      result.putIfAbsent('nameFilter', () => nameFilter as String);
    }

    return result;
  }

  bool _isLatitudeFilled() {
    return lat != null && lat != 0;
  }

  bool _isLongitudeFilled() {
    return lng != null && lng != 0;
  }

  bool _isRadiusFilled() {
    return radius != null && radius != 0;
  }
}
