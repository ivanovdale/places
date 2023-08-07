part of 'place_list_bloc.dart';

final class PlaceListState {
  final PlaceListStatus status;

  final List<Place> places;

  /// Фильтры мест.
  final Set<PlaceTypes> placeTypeFilters;

  /// Радиус поиска.
  final double radius;

  const PlaceListState({
    required this.status,
    required this.places,
    required this.placeTypeFilters,
    required this.radius,
  });

  PlaceListState.initial()
      : status = PlaceListStatus.initial,
        places = const <Place>[],
        placeTypeFilters = PlaceTypes.values.toSet(),
        radius = AppConstants.maxRangeValue;

  PlaceListState copyWith({
    PlaceListStatus? status,
    List<Place>? places,
    Set<PlaceTypes>? placeTypeFilters,
    double? radius,
  }) {
    return PlaceListState(
      status: status ?? this.status,
      places: places ?? this.places,
      placeTypeFilters: placeTypeFilters ?? this.placeTypeFilters,
      radius: radius ?? this.radius,
    );
  }
}

enum PlaceListStatus { initial, loading, success, failure }

typedef PlaceListStatusPlaces = ({PlaceListStatus status, List<Place> places});