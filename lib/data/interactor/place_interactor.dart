import 'package:places/data/repository/place_mapper.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';

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
    final filteredPlacesDto =
        await placeRepository.getFilteredPlaces(placesFilterRequest.toDto());

    final filteredPlaces =
        filteredPlacesDto.map(PlaceMapper.placeFromDto).toList();

    // Сортировка по удалённости, если есть значение расстояния.
    if (filteredPlaces.isNotEmpty && filteredPlaces[0].distance != null) {
      filteredPlaces
          .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
    }

    // Добавляем пометку добавления в избранное для каждого места.
    getFavoritePlaces().forEach((favoritePlace) {
      filteredPlaces
          .firstWhere((filteredPlace) =>
              filteredPlace.id == favoritePlace.id && favoritePlace.isFavorite)
          .isFavorite = true;
    });

    return filteredPlaces;
  }

  /// Возвращает детали места.
  Future<Place> getPlaceDetails(int id) async {
    final placeDto = await placeRepository.getPlaceById(id.toString());

    return PlaceMapper.placeFromDto(placeDto);
  }

  /// Возвращает список мест, планируемых к посещению.
  List<Place> getFavoritePlaces() {
    return _favoritePlaces.where((place) => !place.visited).toList();
  }

  /// Добавляет место в список избранных и делает пометку объекту, что место в избранном.
  void addToFavorites(Place place) {
    _favoritePlaces.add(place);
    place.isFavorite = true;
  }

  /// Удаляет место из списка избранных и снимает пометку объекту, что место в избранном.
  void removeFromFavorites(Place place) {
    _favoritePlaces.remove(place);
    place.isFavorite = false;
  }

  /// Возвращает список посещенных мест.
  List<Place> getVisitedPlaces() {
    return _favoritePlaces.where((place) => place.visited).toList();
  }

  /// Делает пометку, что место посещено.
  void addToVisitedPlaces(Place place) {
    place.visited = true;
  }

  /// Добавляет новое место.
  Future<Place> addNewPlace(Place place) async {
    final placeDto =
        await placeRepository.addNewPlace(PlaceMapper.placeToDto(place));

    return PlaceMapper.placeFromDto(placeDto);
  }
}
