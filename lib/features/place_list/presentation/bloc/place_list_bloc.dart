import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/favourite_places/domain/interactor/favourite_place_interactor.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';

part 'place_list_event.dart';

part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final PlaceInteractor _placeInteractor;
  final PlaceFiltersInteractor _placeFiltersInteractor;
  final FavouritePlaceInteractor _favouritePlaceInteractor;
  late final StreamSubscription<PlaceFilters> _filtersStreamSubscription;

  PlaceListBloc({
    required PlaceInteractor placeInteractor,
    required PlaceFiltersInteractor placeFiltersInteractor,
    required FavouritePlaceInteractor favouritePlaceInteractor,
  })  : _placeInteractor = placeInteractor,
        _placeFiltersInteractor = placeFiltersInteractor,
        _favouritePlaceInteractor = favouritePlaceInteractor,
        super(PlaceListState.initial()) {
    on(_onPlaceFiltersSubscriptionRequested);
    on(_onPlaceListLoadedOrFiltersUpdated);
  }

  @override
  Future<void> close() {
    _filtersStreamSubscription.cancel();
    return super.close();
  }

  Future<void> _onPlaceFiltersSubscriptionRequested(
    PlaceFiltersSubscriptionRequested event,
    Emitter<PlaceListState> emit,
  ) async {
    // Подписка на фильтры.
    _filtersStreamSubscription = _placeFiltersInteractor.placeFilters
        .listen((event) => add(_PlaceFiltersUpdated()));

    // Подписка на избранное.
    await emit.forEach(
      _favouritePlaceInteractor.getFavourites(),
      onData: (favourites) => state.copyWith(
        places: [
          ..._placeInteractor.addFavouriteMarks(
            state.places,
            favourites,
          )
        ],
      ),
    );
  }

  Future<void> _onPlaceListLoadedOrFiltersUpdated(
    PlaceListEvent event,
    Emitter<PlaceListState> emit,
  ) async {
    if (event is! PlaceListStarted &&
        event is! PlaceListLoaded &&
        event is! _PlaceFiltersUpdated) return;

    emit(state.copyWith(status: PlaceListStatus.loading));

    try {
      final newState = await _getStateWithLoadedData();
      emit(newState);
    } on Exception {
      emit(state.copyWith(status: PlaceListStatus.failure));

      rethrow;
    }
  }

  Future<PlaceListState> _getStateWithLoadedData() async {
    final places = await _placeInteractor.getFilteredPlaces(
      useSavedFilters: true,
      sortByDistance: true,
      addFavouriteMark: true,
    );

    return state.copyWith(
      status: PlaceListStatus.success,
      places: places,
    );
  }
}
