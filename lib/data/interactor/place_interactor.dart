import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';
import 'package:places/favourite_places/domain/favourite_place_repository.dart';

/// Интерактор для работы с местами.
class PlaceInteractor {
  /// Репозиторий работы с местами.
  final PlaceRepository placeRepository;

  final FavouritePlaceRepository favouritePlaceRepository;

  PlaceInteractor({
    required this.placeRepository,
    required this.favouritePlaceRepository,
  });

  /// Получает список мест после фильтрации.
  /// Добавляет пометку добавления в избранное для каждого места.
  Future<List<Place>> getFilteredPlaces(
    PlacesFilterRequest placesFilterRequest,
  ) async {
    final filteredPlaces =
        await placeRepository.getFilteredPlaces(placesFilterRequest);

    // Сортировка по удалённости, если есть значение расстояния.
    if (filteredPlaces.isNotEmpty && filteredPlaces[0].distance != null) {
      filteredPlaces
          .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
    }

    // Добавляем пометку добавления в избранное для каждого места.
    getFavoritePlaces()
        .map((favoritePlace) => favoritePlace.id)
        .toList()
        .forEach((favoritePlaceId) {
      final indexOfFilteredPlace = filteredPlaces
          .indexWhere((filteredPlace) => filteredPlace.id == favoritePlaceId);

      filteredPlaces[indexOfFilteredPlace].isFavorite = true;
    });

    return filteredPlaces;
  }

  /// Возвращает детали места.
  Future<Place> getPlaceDetails(int id) async {
    return placeRepository.getPlaceById(id.toString());
  }

  /// Добавляет новое место.
  Future<Place> addNewPlace(Place place) async {
    return placeRepository.addNewPlace(place);
  }
}
