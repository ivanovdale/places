import 'package:places/domain/model/place.dart';
import 'package:places/utils/place_list_ext.dart';

final class FavouritePlacesState {
  final FavouritePlacesStatus status;
  final List<Place> places;

  List<Place> get visitedPlaces => places.filterByVisited();

  List<Place> get notVisitedPlaces => places.filterByNotVisited();

  FavouritePlacesState({
    this.status = FavouritePlacesStatus.loading,
    this.places = const [],
  });

  FavouritePlacesState copyWith({
    FavouritePlacesStatus? status,
    List<Place>? places,
  }) {
    return FavouritePlacesState(
      status: status ?? this.status,
      places: places ?? this.places,
    );
  }
}

enum FavouritePlacesStatus { loading, success, }
