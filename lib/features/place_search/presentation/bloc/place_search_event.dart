part of 'place_search_bloc.dart';

sealed class PlaceSearchEvent {}

final class PlaceSearchStarted extends PlaceSearchEvent {
  final CoordinatePoint userCoordinates;

  PlaceSearchStarted({
    required this.userCoordinates,
  });
}

final class UpdateSearchString extends PlaceSearchEvent {
  final String searchString;

  UpdateSearchString(this.searchString);
}

final class MakeSearch extends PlaceSearchEvent {
  final String searchQuery;

  MakeSearch(this.searchQuery);
}

final class AddToSearchHistory extends PlaceSearchEvent {
  final Place place;

  AddToSearchHistory(this.place);
}

final class RemoveFromSearchHistory extends PlaceSearchEvent {
  final Place place;

  RemoveFromSearchHistory(this.place);
}

final class ClearSearchHistory extends PlaceSearchEvent {}

final class FillSearchString extends PlaceSearchEvent {
  final Place place;

  FillSearchString(this.place);
}
