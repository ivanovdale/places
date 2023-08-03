part of 'place_filters_bloc.dart';

final class PlaceFiltersState {
  /// Список выбранных фильтров по категории мест.
  final Set<PlaceTypes> selectedPlaceTypeFilters;

  /// Радиус поиска места.
  final double radius;

  /// Количество найденных мест.
  final int filteredPlacesAmount;

  const PlaceFiltersState({
    required this.selectedPlaceTypeFilters,
    required this.radius,
    required this.filteredPlacesAmount,
  });

  PlaceFiltersState.initial()
      : selectedPlaceTypeFilters = PlaceTypes.values.toSet(),
        radius = AppConstants.maxRangeValue,
        filteredPlacesAmount = 0;

  PlaceFiltersState copyWith({
    Set<PlaceTypes>? selectedPlaceTypeFilters,
    double? radius,
    int? filteredPlacesAmount,
  }) {
    return PlaceFiltersState(
      selectedPlaceTypeFilters:
          selectedPlaceTypeFilters ?? this.selectedPlaceTypeFilters,
      radius: radius ?? this.radius,
      filteredPlacesAmount: filteredPlacesAmount ?? this.filteredPlacesAmount,
    );
  }
}
