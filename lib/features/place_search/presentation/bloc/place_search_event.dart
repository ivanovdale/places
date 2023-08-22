part of 'place_search_bloc.dart';

sealed class PlaceSearchEvent {}

final class PlaceSearchStarted extends PlaceSearchEvent {
  final CoordinatePoint userCoordinates;

  PlaceSearchStarted({
    required this.userCoordinates,
  });
}

final class SearchStringUpdated extends PlaceSearchEvent {
  final String searchString;

  SearchStringUpdated(this.searchString);
}

final class SearchMade extends PlaceSearchEvent {
  final String searchQuery;

  SearchMade(this.searchQuery);
}

final class ToSearchHistoryAdded extends PlaceSearchEvent {
  final Place place;

  ToSearchHistoryAdded(this.place);
}

final class FromSearchHistoryRemoved extends PlaceSearchEvent {
  final Place place;

  FromSearchHistoryRemoved(this.place);
}

final class SearchHistoryCleared extends PlaceSearchEvent {}

final class SearchStringFilled extends PlaceSearchEvent {
  final Place place;

  SearchStringFilled(this.place);
}
