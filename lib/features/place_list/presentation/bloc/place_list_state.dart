part of 'place_list_bloc.dart';

final class PlaceListState {
  final PlaceListStatus status;

  final List<Place> places;

  const PlaceListState({
    required this.status,
    required this.places,
  });

  PlaceListState.initial()
      : status = PlaceListStatus.initial,
        places = const <Place>[];

  PlaceListState copyWith({
    PlaceListStatus? status,
    List<Place>? places,
  }) {
    return PlaceListState(
      status: status ?? this.status,
      places: places ?? this.places,
    );
  }
}

enum PlaceListStatus { initial, loading, success, failure }

typedef PlaceListStatusPlaces = ({PlaceListStatus status, List<Place> places});
