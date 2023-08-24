import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/features/place_search/domain/interactor/place_search_history_interactor.dart';
import 'package:places/features/place_search/domain/interactor/place_search_interactor.dart';
import 'package:places/features/place_search/domain/model/search_history_item.dart';

part 'place_search_event.dart';

part 'place_search_state.dart';

class PlaceSearchBloc extends Bloc<PlaceSearchEvent, PlaceSearchState> {
  final PlaceSearchInteractor _placeSearchInteractor;
  final PlaceFiltersInteractor _placeFiltersInteractor;
  final PlaceSearchHistoryInteractor _placeSearchHistoryInteractor;

  PlaceSearchBloc({
    required PlaceSearchInteractor placeSearchInteractor,
    required PlaceFiltersInteractor placeFiltersInteractor,
    required PlaceSearchHistoryInteractor placeSearchHistoryInteractor,
  })  : _placeSearchInteractor = placeSearchInteractor,
        _placeFiltersInteractor = placeFiltersInteractor,
        _placeSearchHistoryInteractor = placeSearchHistoryInteractor,
        super(PlaceSearchState.initial()) {
    on<PlaceSearchSubscriptionRequested>(_onSubscriptionRequested);
    on<PlaceSearchStringUpdated>(_onSearchStringUpdated);
    on<PlaceSearchToSearchHistoryAdded>(_onToSearchHistoryAdded);
    on<PlaceSearchFromSearchHistoryRemoved>(_onFromSearchHistoryRemoved);
    on<PlaceSearchSearchHistoryCleared>(_onSearchHistoryCleared);
  }

  Future<void> _onSubscriptionRequested(
    PlaceSearchSubscriptionRequested event,
    Emitter<PlaceSearchState> emit,
  ) async {
    final placeFilters = await _placeFiltersInteractor.placeFilters.first;
    _placeSearchInteractor.setFilters(
      typeFilter: placeFilters.types.toList(),
      radius: placeFilters.radius,
      userCoordinates: event.userCoordinates,
    );

    await emit.forEach<List<SearchHistoryItem>>(
      _placeSearchHistoryInteractor.getSearchHistory(),
      onData: (searchHistory) => state.copyWith(
        searchHistory: searchHistory.toSet(),
      ),
    );
  }

  Future<void> _onSearchStringUpdated(
    PlaceSearchStringUpdated event,
    Emitter<PlaceSearchState> emit,
  ) async {
    final searchString = event.searchString;
    emit(state.copyWith(searchString: searchString));

    if (searchString.isEmpty) return;

    final placesFound =
        await _placeSearchInteractor.getFilteredPlaces(searchString);
    emit(
      state.copyWith(
        placesFoundList: placesFound,
        isSearchInProgress: false,
      ),
    );
  }

  Future<void> _onToSearchHistoryAdded(
    PlaceSearchToSearchHistoryAdded event,
    Emitter<PlaceSearchState> emit,
  ) async {
    final place = event.place;
    final isInHistory = await _placeSearchHistoryInteractor
        .getSearchHistoryItemById(place.id!)
        .then((value) => value != null);

    if (!isInHistory) {
      await _placeSearchHistoryInteractor
          .addToSearchHistory(SearchHistoryItem.fromPlace(place));
    }
  }

  void _onFromSearchHistoryRemoved(
    PlaceSearchFromSearchHistoryRemoved event,
    Emitter<PlaceSearchState> emit,
  ) =>
      _placeSearchHistoryInteractor
          .removeFromSearchHistory(event.searchHistoryItem.id);

  void _onSearchHistoryCleared(
    PlaceSearchSearchHistoryCleared event,
    Emitter<PlaceSearchState> emit,
  ) =>
      _placeSearchHistoryInteractor.clearSearchHistory();
}
