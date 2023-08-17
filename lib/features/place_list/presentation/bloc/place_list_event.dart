part of 'place_list_bloc.dart';

sealed class PlaceListEvent {}

final class PlaceListStarted extends PlaceListEvent {}

final class PlaceListLoaded extends PlaceListEvent {}

final class PlaceListWithFiltersLoaded extends PlaceListEvent {
  final PlaceFilters placeFilters;

  PlaceListWithFiltersLoaded({
    required this.placeFilters,
  });
}
