import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/place_search/domain/place_search_interactor.dart';

part 'place_search_event.dart';

part 'place_search_state.dart';

class PlaceSearchBloc extends Bloc<PlaceSearchEvent, PlaceSearchState> {
  final PlaceSearchInteractor _placeSearchInteractor;

  PlaceSearchBloc(this._placeSearchInteractor)
      : super(PlaceSearchState.initial()) {
    on<PlaceSearchStarted>(_onPlaceSearchStarted);
    on<UpdateSearchString>(_onUpdateSearchString);
    on<MakeSearch>(_onMakeSearch);
    on<AddToSearchHistory>(_onAddToSearchHistory);
    on<RemoveFromSearchHistory>(_onRemoveFromSearchHistory);
    on<ClearSearchHistory>(_onClearSearchHistory);
    on<FillSearchString>(_onFillSearchString);
  }

  void _onPlaceSearchStarted(
    PlaceSearchStarted event,
    Emitter<PlaceSearchState> emit,
  ) {
    _placeSearchInteractor.setFilters(
      typeFilter: event.placeTypeFilters,
      radius: event.radius,
      userCoordinates: event.userCoordinates,
    );
  }

  void _onUpdateSearchString(
    UpdateSearchString event,
    Emitter<PlaceSearchState> emit,
  ) {
    final newState = state.copyWith(
      searchString: event.searchString,
    );

    emit(newState);
  }

  Future<void> _onMakeSearch(
    MakeSearch event,
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

  void _onAddToSearchHistory(
    AddToSearchHistory event,
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

  void _onRemoveFromSearchHistory(
    RemoveFromSearchHistory event,
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

  void _onClearSearchHistory(
    ClearSearchHistory event,
    Emitter<PlaceSearchState> emit,
  ) {
    emit(
      state.copyWith(searchHistory: {}),
    );
  }

  void _onFillSearchString(
    FillSearchString event,
    Emitter<PlaceSearchState> emit,
  ) {
    emit(
      state.copyWith(searchString: event.place.name),
    );
  }
}
