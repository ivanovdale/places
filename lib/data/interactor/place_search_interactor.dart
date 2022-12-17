import 'package:places/data/repository/place_mapper.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';

/// Интерактор для работы с поиском мест.
class PlaceSearchInteractor {
  /// Фильтр по типу мест.
  late final List<PlaceTypes>? typeFilter;

  /// Радиус поиска мест.
  late final double radius;

  /// Координаты пользователя для поиска мест с учетом радиуса.
  late final CoordinatePoint userCoordinates;

  /// История поиска мест.
  final Set<Place> searchHistory = {};

  /// Репозиторий работы с местами.
  PlaceRepository placeRepository;

  PlaceSearchInteractor(this.placeRepository);

  /// Получает список мест после фильтрации по имени (и другим ранее сохраненным параметрам).
  Future<List<Place>> getFilteredPlaces(
    String name,
  ) async {
    final placesFilterRequest = PlacesFilterRequest(
      coordinatePoint: userCoordinates,
      radius: radius,
      typeFilter: typeFilter,
      nameFilter: name,
    );

    final filteredPlacesDto =
        await placeRepository.getFilteredPlaces(placesFilterRequest.toDto());

    return filteredPlacesDto.map(PlaceMapper.placeFromDto).toList();
  }

  /// Удаляет все места из списка истории поиска.
  void clearSearchHistory() {
    searchHistory.clear();
  }

  /// Удаляет место из списка истории поиска.
  void removeFromSearchHistory(Place place) {
    searchHistory.remove(place);
  }

  /// Добавляет место в список истории поиска.
  void addToSearchHistory(Place place) {
    searchHistory.add(place);
  }
}
