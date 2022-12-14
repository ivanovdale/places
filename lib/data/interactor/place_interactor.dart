import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';

/// Интерактор для работы с местами.
class PlaceInteractor {
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

    final filteredPlaces = filteredPlacesDto.map(Place.fromDto).toList();

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

    return Place.fromDto(placeDto);
  }

  /// Получает избранные места.
  List<Place> getFavoritePlaces() {
    return placeRepository.getFavoritePlaces();
  }

  /// Добавляет место в избранное.
  void addToFavorites(Place place) {
    placeRepository.addToFavorites(place);
  }

  /// Удаляет место из избранного.
  void removeFromFavorites(Place place) {
    placeRepository.removeFromFavorites(place);
  }

  /// Возвращает список посещенных мест.
  List<Place> getVisitedPlaces() {
    return placeRepository.getVisitedPlaces();
  }

  /// Добавляет место в список посещенных.
  void addToVisitedPlaces(Place place) {
    placeRepository.addToVisitedPlaces(place);
  }

  /// Добавляет новое место.
  Future<Place> addNewPlace(Place place) async {
    final placeDto = await placeRepository.addNewPlace(place.toDto());

    return Place.fromDto(placeDto);
  }
}
