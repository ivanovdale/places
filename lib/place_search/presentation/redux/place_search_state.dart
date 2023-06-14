import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';

final class PlaceSearchState {
  final List<PlaceTypes> placeTypeFilters;
  final double radius;
  final CoordinatePoint userCoordinates;

  /// Найденные места.
  List<Place> placesFoundList;

  /// История поиска мест.
  Set<Place> searchHistory;

  /// Флаг начала процесса поиска мест.
  bool isSearchInProgress;

  /// Данные строки поиска.
  String searchString;

  bool get isSearchStringEmpty => searchString.isEmpty;

  PlaceSearchState({
    required this.placeTypeFilters,
    required this.radius,
    required this.userCoordinates,
    required this.placesFoundList,
    required this.searchHistory,
    required this.isSearchInProgress,
    required this.searchString,
  });

  PlaceSearchState.initial()
      : placeTypeFilters = [],
        radius = 0.0,
        userCoordinates = CoordinatePoint.empty(),
        placesFoundList = const [],
        searchHistory = const {},
        isSearchInProgress = false,
        searchString = '';

  PlaceSearchState copyWith({
    List<PlaceTypes>? placeTypeFilters,
    double? radius,
    CoordinatePoint? userCoordinates,
    List<Place>? placesFoundList,
    Set<Place>? searchHistory,
    bool? isSearchInProgress,
    String? searchString,
  }) {
    return PlaceSearchState(
      placeTypeFilters: placeTypeFilters ?? this.placeTypeFilters,
      radius: radius ?? this.radius,
      userCoordinates: userCoordinates ?? this.userCoordinates,
      placesFoundList: placesFoundList ?? this.placesFoundList,
      searchHistory: searchHistory ?? this.searchHistory,
      isSearchInProgress: isSearchInProgress ?? this.isSearchInProgress,
      searchString: searchString ?? this.searchString,
    );
  }
}
