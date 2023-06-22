import 'package:places/features/place_search/presentation/redux/place_search_actions.dart';
import 'package:places/features/place_search/presentation/redux/place_search_state.dart';
import 'package:redux/redux.dart';

final placesSearchReducers = combineReducers<PlaceSearchState>(
  [
    TypedReducer<PlaceSearchState, InitializeSearchFilters>(
      initializeSearchFilters,
    ),
    TypedReducer<PlaceSearchState, UpdateSearchString>(
      updateSearchString,
    ),
    TypedReducer<PlaceSearchState, ToggleSearchHistory>(
      toggleSearchHistory,
    ),
    TypedReducer<PlaceSearchState, ClearSearchHistory>(
      clearSearchHistory,
    ),
    TypedReducer<PlaceSearchState, MakeSearchInProgress>(
      makeSearchInProgress,
    ),
    TypedReducer<PlaceSearchState, MakeSearchResult>(
      makeSearchResult,
    ),
    TypedReducer<PlaceSearchState, FillSearchString>(
      fillSearchString,
    ),
  ],
);

PlaceSearchState initializeSearchFilters(
  PlaceSearchState state,
  InitializeSearchFilters action,
) {
  final newState = state.copyWith(
    placeTypeFilters: action.placeTypeFilters,
    radius: action.radius,
    userCoordinates: action.userCoordinates,
  );

  return newState;
}

PlaceSearchState updateSearchString(
  PlaceSearchState state,
  UpdateSearchString action,
) {
  final newState = state.copyWith(
    searchString: action.searchString,
  );

  return newState;
}

PlaceSearchState toggleSearchHistory(
  PlaceSearchState state,
  ToggleSearchHistory action,
) {
  final place = action.place;
  final searchHistory = {...state.searchHistory};
  if (searchHistory.contains(place)) {
    searchHistory.remove(place);
  } else {
    searchHistory.add(place);
  }

  final newState = state.copyWith(
    searchHistory: searchHistory,
  );

  return newState;
}

PlaceSearchState clearSearchHistory(
  PlaceSearchState state,
  // ignore: avoid-unused-parameters
  ClearSearchHistory action,
) {
  final newState = state.copyWith(
    searchHistory: {},
  );

  return newState;
}

PlaceSearchState makeSearchInProgress(
  PlaceSearchState state,
  // ignore: avoid-unused-parameters
  MakeSearchInProgress action,
) {
  final newState = state.copyWith(
    isSearchInProgress: true,
  );

  return newState;
}

PlaceSearchState makeSearchResult(
  PlaceSearchState state,
  MakeSearchResult action,
) {
  final newState = state.copyWith(
    placesFoundList: action.placesFound,
    isSearchInProgress: false,
  );

  return newState;
}

PlaceSearchState fillSearchString(
  PlaceSearchState state,
  FillSearchString action,
) {
  final newState = state.copyWith(
    searchString: action.place.name,
  );

  return newState;
}
