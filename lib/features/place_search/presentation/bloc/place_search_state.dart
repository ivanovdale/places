part of 'place_search_bloc.dart';

final class PlaceSearchState {
  /// Найденные места.
  List<Place> placesFoundList;

  /// История поиска мест.
  Set<SearchHistoryItem> searchHistory;

  /// Флаг начала процесса поиска мест.
  bool isSearchInProgress;

  /// Данные строки поиска.
  String searchString;

  bool get isSearchStringEmpty => searchString.isEmpty;

  PlaceSearchState({
    required this.placesFoundList,
    required this.searchHistory,
    required this.isSearchInProgress,
    required this.searchString,
  });

  PlaceSearchState.initial()
      : placesFoundList = const [],
        searchHistory = const {},
        isSearchInProgress = false,
        searchString = '';

  PlaceSearchState copyWith({
    List<Place>? placesFoundList,
    Set<SearchHistoryItem>? searchHistory,
    bool? isSearchInProgress,
    String? searchString,
  }) {
    return PlaceSearchState(
      placesFoundList: placesFoundList ?? this.placesFoundList,
      searchHistory: searchHistory ?? this.searchHistory,
      isSearchInProgress: isSearchInProgress ?? this.isSearchInProgress,
      searchString: searchString ?? this.searchString,
    );
  }
}
