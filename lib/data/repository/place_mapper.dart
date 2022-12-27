import 'package:places/data/dto/place_dto.dart';
import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';

/// Маппер для преобразования данных из DTO в данные для UI и обратно.
class PlaceMapper {
  /// Преобразует DTO в данные для UI.
  static Place placeFromDto(PlaceDTO placeDTO) {
    return Place(
      id: placeDTO.id,
      name: placeDTO.name,
      coordinatePoint: CoordinatePoint(
        lat: placeDTO.lat,
        lon: placeDTO.lng,
      ),
      details: placeDTO.description,
      type: PlaceTypes.values.byName(placeDTO.placeType),
      photoUrlList: placeDTO.urls,
      distance: placeDTO.distance,
    );
  }

  /// Преобразует данные для UI в DTO.
  static PlaceDTO placeToDto(Place place) {
    return PlaceDTO(
      id: place.id,
      lat: place.coordinatePoint.lat,
      lng: place.coordinatePoint.lon,
      name: place.name,
      urls: place.photoUrlList ?? <String>[],
      placeType: place.type.name,
      description: place.details,
    );
  }
}
