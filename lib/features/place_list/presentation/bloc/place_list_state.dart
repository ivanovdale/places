part of 'place_list_bloc.dart';

final class PlaceListState {
  final PlaceListStatus status;

  final List<Place> places;

  final PlaceFilters placeFilters;

  const PlaceListState({
    required this.status,
    required this.places,
    required this.placeFilters,
  });

  PlaceListState.initial()
      : status = PlaceListStatus.initial,
        places = const <Place>[],
        placeFilters = (
          types: PlaceTypes.values.toSet(),
          radius: AppConstants.maxRangeValue,
        );

  PlaceListState copyWith({
    PlaceListStatus? status,
    List<Place>? places,
    PlaceFilters? placeFilters,
  }) {
    return PlaceListState(
      status: status ?? this.status,
      places: places ?? this.places,
      placeFilters: placeFilters ?? this.placeFilters,
    );
  }
}

enum PlaceListStatus { initial, loading, success, failure }

typedef PlaceListStatusPlaces = ({PlaceListStatus status, List<Place> places});
