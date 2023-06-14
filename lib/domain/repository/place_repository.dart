import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';

/// Получает данные мест.
abstract class PlaceRepository {
  /// Получает место по id.
  Future<Place> getPlaceById(String id);

  /// Получает все места.
  Future<List<Place>> getPlaces();

  /// Добавляет новое место.
  Future<Place> addNewPlace(Place place);

  /// Получает места в соответствии с фильтром.
  Future<List<Place>> getFilteredPlaces(
    PlacesFilterRequest placesFilterRequest,
  );
}
