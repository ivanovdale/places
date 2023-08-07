part of 'place_list_bloc.dart';

sealed class PlaceListEvent {}

final class PlaceListStarted extends PlaceListEvent {}

final class PlaceListLoaded extends PlaceListEvent {}

final class PlaceListWithFiltersLoaded extends PlaceListEvent {
  /// Фильтры мест.
  final Set<PlaceTypes> placeTypeFilters;

  /// Радиус поиска.
  final double radius;

  PlaceListWithFiltersLoaded({
    required this.placeTypeFilters,
    required this.radius,
  });
}
