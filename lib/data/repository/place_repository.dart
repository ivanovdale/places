import 'package:places/data/dto/place_dto.dart';
import 'package:places/data/dto/places_filter_request_dto.dart';
import 'package:places/domain/model/place.dart';

/// Получает данные мест.
abstract class PlaceRepository {

  /// Получает место по id.
  Future<PlaceDTO> getPlaceById(String id);

  /// Получает все места.
  Future<List<PlaceDTO>> getPlaces();

  /// Добавляет новое место.
  Future<PlaceDTO> addNewPlace(PlaceDTO placeDto);

  /// Получает места в соответствии с фильтром.
  Future<List<PlaceDTO>> getFilteredPlaces(
    PlacesFilterRequestDto placesFilterRequestDto,
  );

  /// Получает избранные места.
  List<Place> getFavoritePlaces();

  /// Добавляет место в избранное.
  void addToFavorites(Place place);

  /// Удаляет место из избранного.
  void removeFromFavorites(Place place);

  /// Получает посещенные места.
  List<Place> getVisitedPlaces();

  /// Добавляет место в посещенные места.
  void addToVisitedPlaces(Place place);
}
