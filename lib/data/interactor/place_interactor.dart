import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';
import 'package:places/domain/repository/place_repository.dart';

/// Интерактор для работы с местами.
class PlaceInteractor {
  // Список избранных мест пользователя.
  final List<Place> _favoritePlaces = [];

  /// Репозиторий работы с местами.
  PlaceRepository placeRepository;

  PlaceInteractor(this.placeRepository);

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

  /// Возвращает список избранных мест.
  List<Place> getFavoritePlaces() {
    return _favoritePlaces;
  }

  /// Возвращает список мест, планируемых к посещению.
  List<Place> getToVisitPlaces() {
    return _favoritePlaces.where((place) => !place.visited).toList();
  }

  /// Возвращает список посещенных мест.
  List<Place> getVisitedPlaces() {
    return _favoritePlaces.where((place) => place.visited).toList();
  }

  /// Добавляет место в список избранных и делает пометку объекту, что место в избранном.
  /// Удаляет место из списка избранных и снимает пометку объекту, что место в избранном.
  void toggleFavorites(Place place) {
    final isFavorite = place.isFavorite;
    place.isFavorite = !place.isFavorite;
    isFavorite
        ? _favoritePlaces
            .removeWhere((favoritePlace) => favoritePlace.id == place.id)
        : _favoritePlaces.add(place);
  }

  /// Делает пометку, что место посещено.
  void addToVisitedPlaces(Place place) {
    place.visited = true;
  }

  /// Добавляет новое место.
  Future<Place> addNewPlace(Place place) async {
    return placeRepository.addNewPlace(place);
  }
}
