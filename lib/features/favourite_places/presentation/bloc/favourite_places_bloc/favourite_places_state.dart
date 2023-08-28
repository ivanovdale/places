import 'package:places/core/domain/model/place.dart';
import 'package:places/core/utils/place_list_ext.dart';

final class FavouritePlacesState {
  final FavouritePlacesStatus status;
  final List<Place> _favourites;

  List<Place> get visitedPlaces => _favourites.filterByVisited();

  List<Place> get notVisitedPlaces => _favourites.filterByNotVisited();

  FavouritePlacesState({
    this.status = FavouritePlacesStatus.loading,
    List<Place> favourites = const [],
  }) : _favourites = favourites;

  FavouritePlacesState copyWith({
    FavouritePlacesStatus? status,
    List<Place>? favourites,
  }) {
    return FavouritePlacesState(
      status: status ?? this.status,
      favourites: favourites ?? _favourites,
    );
  }
}

enum FavouritePlacesStatus { loading, success }
