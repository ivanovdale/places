import 'package:places/domain/coordinate_point.dart';
import 'package:places/domain/sight.dart';

/// Миксин, содержащий методы для работы с достопримечательностями.
mixin WorkWithPlaces {
  /// Возвращает места после фильтрации по категории и расстоянию.
  List<Sight> getFilteredByTypeAndRadiusSights(
    List<Sight> sights,
    List<Map<String, Object>> listOfSightTypeFilters,
    CoordinatePoint userCoordinates,
    Map<String, double> range,
  ) {
    final selectedSightTypeFilterNames =
        getSelectedSightTypeFilterNames(listOfSightTypeFilters);

    return sights
        .where(
          (sight) => selectedSightTypeFilterNames.contains(sight.type.name),
        )
        .where((sight) => sight.coordinatePoint.isPointInsideRadius(
              userCoordinates,
              range['distanceFrom']!,
              range['distanceTo']!,
            ))
        .toList();
  }

  /// Возвращает места после фильтрации по наименованию.
  List<Sight> getFilteredByNameSights(List<Sight> sights, String sightName) {
    return sights
        .where(
          (sight) => sight.name.toLowerCase().contains(sightName.toLowerCase()),
        )
        .toList();
  }

  /// Возвращает выбранные категории.
  List<String> getSelectedSightTypeFilterNames(
    List<Map<String, Object>> listOfSightTypeFilters,
  ) {
    return listOfSightTypeFilters
        .where((sightTypeFilter) => sightTypeFilter['selected'] as bool)
        .toList()
        .map((sightType) => sightType['name'] as String)
        .toList();
  }

  /// Возвращает, выбрана ли категория.
  bool isSightTypeFilterSelected(
    List<Map<String, Object>> sightTypeFilters,
    String sightTypeFilterName,
  ) {
    return getSelectedSightTypeFilterNames(sightTypeFilters)
        .contains(sightTypeFilterName);
  }
}
