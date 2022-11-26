import 'dart:convert';

import 'package:places/data/model/place.dart';

/// Возвращает тело для добавления нового места.
///
/// Пример сформированного тела:
///
/// ```JSON
/// {
///   "id": 0,
///  "lat": 0,
///   "lng": 0,
///   "name": "string",
///   "urls": [
///     "string"
///   ],
///   "placeType": "temple",
///   "description": "string"
/// }
/// ```
class GetNewPlaceBody {
  static String toApi(Place place) {
    final body = <String, dynamic>{
      'id': place.id,
      'lat': place.coordinatePoint.lat,
      'lng': place.coordinatePoint.lon,
      'name': place.name,
      'urls': place.photoUrlList,
      'placeType': place.type.toString(),
      'description': place.details,
    };

    final result = jsonEncode(body);

    return result;
  }
}
