import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';
import 'package:places/domain/repository/place_repository.dart';

/// Интерактор для работы с поиском мест.
class PlaceSearchInteractor {
  /// Репозиторий работы с местами.
  final PlaceRepository _placeRepository;

  /// Фильтр по типу мест.
  late List<PlaceTypes>? _typeFilter;

  /// Радиус поиска мест.
  late double _radius;

  /// Координаты пользователя для поиска мест с учетом радиуса.
  late CoordinatePoint _userCoordinates;

  PlaceSearchInteractor(this._placeRepository);

  void setFilters({
    List<PlaceTypes>? typeFilter,
    required double radius,
    required CoordinatePoint userCoordinates,
  }) {
    _typeFilter = typeFilter;
    _radius = radius;
    _userCoordinates = userCoordinates;
  }

  /// Получает список мест после фильтрации по имени (и другим ранее сохраненным параметрам).
  Future<List<Place>> getFilteredPlaces(String name) async {
    final placesFilterRequest = PlacesFilterRequest(
      coordinatePoint: _userCoordinates,
      radius: _radius,
      typeFilter: _typeFilter,
      nameFilter: name,
    );

    final filteredPlaces =
        await _placeRepository.getFilteredPlaces(placesFilterRequest);

    return filteredPlaces;
  }
}
