part of 'favourite_place_bloc.dart';

final class FavouritePlaceState {
  final Place place;

  const FavouritePlaceState(this.place);

  FavouritePlaceState copyWith({
    Place? place,
  }) {
    return FavouritePlaceState(
      place ?? this.place,
    );
  }
}
