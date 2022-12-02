/// Модель данных ответа на запрос фильтра мест/тела запроса добавления нового места.
///
/// От модели данных места Place отличается наличием поля distance, в котором при ответе будет расстояние от запрошенной точки.
class PlaceDTO {
  final int id;
  final double lat;
  final double lng;
  final double? distance;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  PlaceDTO({
    required this.id,
    required this.lat,
    required this.lng,
    this.distance,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  PlaceDTO.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as int,
          lat: json['lat'] as double,
          lng: json['lng'] as double,
          distance: json['distance'] as double?,
          name: json['name'] as String,
          urls: (json['urls'] as List<dynamic>).cast<String>(),
          placeType: json['placeType'] as String,
          description: json['description'] as String,
        );

  Map<String, Object> toJson() => {
        'id': id,
        'lat': lat,
        'lng': lng,
        'name': name,
        'urls': urls,
        'placeType': placeType,
        'description': description,
      };
}
