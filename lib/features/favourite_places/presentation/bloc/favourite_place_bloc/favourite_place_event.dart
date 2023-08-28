sealed class FavouritePlaceEvent {}

final class FavouritePlaceToVisitPlaceDateTimeUpdated
    extends FavouritePlaceEvent {
  final DateTime dateTime;

  FavouritePlaceToVisitPlaceDateTimeUpdated({
    required this.dateTime,
  });
}
