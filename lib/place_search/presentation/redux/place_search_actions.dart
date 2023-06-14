// ignore_for_file: prefer-match-file-name
import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';

final class InitializeSearchFilters {
  final List<PlaceTypes> placeTypeFilters;
  final double radius;
  final CoordinatePoint userCoordinates;

  InitializeSearchFilters({
    required this.placeTypeFilters,
    required this.radius,
    required this.userCoordinates,
  });
}

final class UpdateSearchString {
  final String searchString;

  UpdateSearchString(this.searchString);
}

final class MakeSearch {
  final String searchQuery;

  MakeSearch(this.searchQuery);
}

final class MakeSearchInProgress {}

final class MakeSearchResult {
  final List<Place> placesFound;

  MakeSearchResult(this.placesFound);
}

final class ToggleSearchHistory {
  final Place place;

  ToggleSearchHistory(this.place);
}

final class ClearSearchHistory {}

final class FillSearchString {
  final Place place;

  FillSearchString(this.place);
}
