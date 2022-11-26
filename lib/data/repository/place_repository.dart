import 'package:places/data/model/place.dart';

/// Получает данные мест.
abstract class PlaceRepository {
  Future<Place> getPlaceById(String id);
  Future<List<Place>> getPlaces();
  Future<Place> addNewPlace(Place place);
}