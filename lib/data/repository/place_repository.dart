import 'package:places/data/dto/places_filter_request_dto.dart';
import 'package:places/domain/model/place.dart';

/// Получает данные мест.
abstract class PlaceRepository {
  Future<Place> getPlaceById(String id);
  Future<List<Place>> getPlaces();
  Future<Place> addNewPlace(Place place);
}