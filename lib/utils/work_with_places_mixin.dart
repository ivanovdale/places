import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';

/// Миксин, содержащий методы для работы с местами.
mixin WorkWithPlaces {
  /// Возвращает места после фильтрации по категории и расстоянию.
  List<Place> getFilteredByTypeAndRadiusPlaces(
    List<Place> places,
    List<Map<String, Object>> listOfPlaceTypeFilters,
    CoordinatePoint userCoordinates,
    Map<String, double> range,
  ) {
    final selectedPlaceTypeFilterNames =
        getSelectedPlaceTypeFilterNames(listOfPlaceTypeFilters);

    return places
        .where(
          (place) => selectedPlaceTypeFilterNames.contains(place.type.name),
        )
        .where((place) => place.coordinatePoint.isPointInsideRadius(
              userCoordinates,
              range['distanceFrom']!,
              range['distanceTo']!,
            ))
        .toList();
  }

  /// Возвращает места после фильтрации по наименованию.
  List<Place> getFilteredByNamePlaces(List<Place> places, String placeName) {
    return places
        .where(
          (place) => place.name.toLowerCase().contains(placeName.toLowerCase()),
        )
        .toList();
  }

  /// Возвращает выбранные категории.
  List<String> getSelectedPlaceTypeFilterNames(
    List<Map<String, Object>> listOfPlaceTypeFilters,
  ) {
    return listOfPlaceTypeFilters
        .where((placeTypeFilter) => placeTypeFilter['selected'] as bool)
        .toList()
        .map((placeType) => placeType['name'] as String)
        .toList();
  }

  /// Возвращает, выбрана ли категория.
  bool isPlaceTypeFilterSelected(
    List<Map<String, Object>> placeTypeFilters,
    String placeTypeFilterName,
  ) {
    return getSelectedPlaceTypeFilterNames(placeTypeFilters)
        .contains(placeTypeFilterName);
  }
}
