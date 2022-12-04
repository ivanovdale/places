import 'package:places/data/dto/places_filter_request_dto.dart';
import 'package:places/domain/model/place.dart';

/// Получает данные мест.
abstract class PlaceRepository {

  // TODO(daniiliv): doc
  Future<Place> getPlaceById(String id);

  // TODO(daniiliv): doc
  Future<List<Place>> getPlaces();

  // TODO(daniiliv): doc
  Future<Place> addNewPlace(Place place);

  // TODO(daniiliv): doc
  Future<List<Place>> getFilteredPlaces(
    PlacesFilterRequestDto placesFilterRequestDto,
  );

  // TODO(daniiliv): doc
  Future<List<Place>> getFavoritePlaces();

  // TODO(daniiliv): doc
  Future<void> addToFavorites(Place place);

  // TODO(daniiliv): doc
  Future<void> removeFromFavorites(Place place);

  // TODO(daniiliv): doc
  Future<List<Place>> getVisitedPlaces();

  // TODO(daniiliv): doc
  Future<void> addToVisitedPlaces(Place place);
}
