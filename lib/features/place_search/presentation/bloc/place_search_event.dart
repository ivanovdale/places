part of 'place_search_bloc.dart';

sealed class PlaceSearchEvent {}

final class PlaceSearchSubscriptionRequested extends PlaceSearchEvent {
  final CoordinatePoint userCoordinates;

  PlaceSearchSubscriptionRequested({
    required this.userCoordinates,
  });
}

final class PlaceSearchStringUpdated extends PlaceSearchEvent {
  final String searchString;

  PlaceSearchStringUpdated(this.searchString);
}

final class PlaceSearchToSearchHistoryAdded extends PlaceSearchEvent {
  final Place place;

  PlaceSearchToSearchHistoryAdded(this.place);
}

final class PlaceSearchFromSearchHistoryRemoved extends PlaceSearchEvent {
  final SearchHistoryItem searchHistoryItem;

  PlaceSearchFromSearchHistoryRemoved(this.searchHistoryItem);
}

final class PlaceSearchSearchHistoryCleared extends PlaceSearchEvent {}
