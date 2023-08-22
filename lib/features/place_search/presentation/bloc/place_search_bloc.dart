import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/features/place_search/domain/place_search_interactor.dart';

part 'place_search_event.dart';

part 'place_search_state.dart';

class PlaceSearchBloc extends Bloc<PlaceSearchEvent, PlaceSearchState> {
  final PlaceSearchInteractor _placeSearchInteractor;
  final PlaceFiltersInteractor _placeFiltersInteractor;

  PlaceSearchBloc({
    required PlaceSearchInteractor placeSearchInteractor,
    required PlaceFiltersInteractor placeFiltersInteractor,
  })  : _placeSearchInteractor = placeSearchInteractor,
        _placeFiltersInteractor = placeFiltersInteractor,
        super(PlaceSearchState.initial()) {
    on<PlaceSearchStarted>(_onPlaceSearchStarted);
    on<SearchStringUpdated>(_onSearchStringUpdated);
    on<SearchMade>(_onSearchMade);
    on<ToSearchHistoryAdded>(_onToSearchHistoryAdded);
    on<FromSearchHistoryRemoved>(_onFromSearchHistoryRemoved);
    on<SearchHistoryCleared>(_onSearchHistoryCleared);
    on<SearchStringFilled>(_onSearchStringFilled);
  }

  Future<void> _onPlaceSearchStarted(
    PlaceSearchStarted event,
    Emitter<PlaceSearchState> emit,
  ) async {
    final placeFilters = await _placeFiltersInteractor.placeFilters.first;
    _placeSearchInteractor.setFilters(
      typeFilter: placeFilters.types.toList(),
      radius: placeFilters.radius,
      userCoordinates: event.userCoordinates,
    );
  }

  void _onSearchStringUpdated(
    SearchStringUpdated event,
    Emitter<PlaceSearchState> emit,
  ) {
    final newState = state.copyWith(
      searchString: event.searchString,
    );

    emit(newState);
  }

  Future<void> _onSearchMade(
    SearchMade event,
    Emitter<PlaceSearchState> emit,
  ) async {
    emit(
      state.copyWith(isSearchInProgress: true),
    );

    final placesFound = await _placeSearchInteractor.getFilteredPlaces(
      event.searchQuery,
    );

    emit(
      state.copyWith(
        placesFoundList: placesFound,
        isSearchInProgress: false,
      ),
    );
  }

  void _onToSearchHistoryAdded(
    ToSearchHistoryAdded event,
    Emitter<PlaceSearchState> emit,
  ) {
    final place = event.place;
    final searchHistory = {...state.searchHistory};
    if (!searchHistory.contains(place)) {
      searchHistory.add(place);
    }

    emit(
      state.copyWith(
        searchHistory: searchHistory,
      ),
    );
  }

  void _onFromSearchHistoryRemoved(
    FromSearchHistoryRemoved event,
    Emitter<PlaceSearchState> emit,
  ) {
    final place = event.place;
    final searchHistory = {...state.searchHistory}..remove(place);

    emit(
      state.copyWith(
        searchHistory: searchHistory,
      ),
    );
  }

  void _onSearchHistoryCleared(
    SearchHistoryCleared event,
    Emitter<PlaceSearchState> emit,
  ) {
    emit(
      state.copyWith(searchHistory: {}),
    );
  }

  void _onSearchStringFilled(
    SearchStringFilled event,
    Emitter<PlaceSearchState> emit,
  ) {
    emit(
      state.copyWith(searchString: event.place.name),
    );
  }
}
