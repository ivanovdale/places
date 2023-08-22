part of 'place_filters_bloc.dart';

sealed class PlaceFiltersEvent {}

final class PlaceFiltersStarted extends PlaceFiltersEvent {
  PlaceFiltersStarted();
}

final class PlaceFiltersAllFiltersReset extends PlaceFiltersEvent {
  PlaceFiltersAllFiltersReset();
}

final class PlaceFiltersTypeFilterSelected extends PlaceFiltersEvent {
  final PlaceTypes placeType;

  PlaceFiltersTypeFilterSelected({
    required this.placeType,
  });
}

final class PlaceFiltersRadiusSelected extends PlaceFiltersEvent {
  final double radius;

  PlaceFiltersRadiusSelected({
    required this.radius,
  });
}

final class PlaceFiltersSaved extends PlaceFiltersEvent {
  PlaceFiltersSaved();
}

/// Внутреннее событие обновления фильтров поиска места.
///
/// [https://bloclibrary.dev/#/faqs?id=adding-events-within-a-bloc].
final class _PlaceFiltersUpdated extends PlaceFiltersEvent {
  _PlaceFiltersUpdated();
}

final class _PlaceFiltersWithDelayUpdated extends PlaceFiltersEvent {
  _PlaceFiltersWithDelayUpdated();
}
