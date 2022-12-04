import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/place.dart';

// TODO(daniiliv): doc
class PlaceInteractor {
  PlaceRepository placeRepository;

  PlaceInteractor(this.placeRepository);

  // TODO(daniiliv): Уточнить и допилить
  // /// Возвращает места после фильтрации по категории и расстоянию.
  // List<Place> getFilteredByTypeAndRadiusPlaces(
  //     List<Place> places,
  //     List<Map<String, Object>> listOfPlaceTypeFilters,
  //     CoordinatePoint userCoordinates,
  //     Map<String, double> range,
  //     ) {
  //   // final selectedPlaceTypeFilterNames =
  //   // getSelectedPlaceTypeFilterNames(listOfPlaceTypeFilters);
  //   //
  //   // return places
  //   //     .where(
  //   //       (place) => selectedPlaceTypeFilterNames.contains(place.type.name),
  //   // )
  //   //     .where((place) => place.coordinatePoint.isPointInsideRadius(
  //   //   userCoordinates,
  //   //   range['distanceFrom']!,
  //   //   range['distanceTo']!,
  //   // ))
  //   //     .toList();
  // }

  // TODO(daniiliv): doc
  Future<Place> getPlaceDetails(int id) async {
    final result = await placeRepository.getPlaceById(id.toString());

    return result;
  }

  // TODO(daniiliv): doc
  Future<List<Place>> getFavoritePlaces() {
    return placeRepository.getFavoritePlaces();
  }

  // TODO(daniiliv): doc
  void addToFavorites(Place place) {
    placeRepository.addToFavorites(place);
  }

  // TODO(daniiliv): doc
  void removeFromFavorites(Place place) {
    placeRepository.removeFromFavorites(place);
  }

  // TODO(daniiliv): doc
  Future<List<Place>> getVisitedPlaces() {
    return placeRepository.getVisitedPlaces();
  }

  // TODO(daniiliv): doc
  void addToVisitedPlaces(Place place) {
    placeRepository.addToVisitedPlaces(place);
  }

  // TODO(daniiliv): doc
  void addNewPlace(Place place) {
    placeRepository.addNewPlace(place);
  }
}
