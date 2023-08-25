import 'package:places/core/domain/model/place.dart';

sealed class FavouritePlacesEvent {}

final class FavouritePlacesSubscriptionRequested extends FavouritePlacesEvent {}

final class FavouritePlacesToFavouritesPressed extends FavouritePlacesEvent {
  final Place place;

  FavouritePlacesToFavouritesPressed(this.place);
}

final class FavouritePlacesPlaceInserted extends FavouritePlacesEvent {
  final Place place;
  final Place targetPlace;

  FavouritePlacesPlaceInserted({
    required this.place,
    required this.targetPlace,
  });
}
