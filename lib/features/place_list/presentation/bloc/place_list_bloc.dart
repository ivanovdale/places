import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/domain/model/places_filter_request.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/mocks.dart' as mocked;

part 'place_list_event.dart';

part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final PlaceInteractor _placeInteractor;
  final PlaceFiltersInteractor _placeFiltersInteractor;

  PlaceListBloc({
    required PlaceInteractor placeInteractor,
    required PlaceFiltersInteractor placeFiltersInteractor,
  })  : _placeInteractor = placeInteractor,
        _placeFiltersInteractor = placeFiltersInteractor,
        super(PlaceListState.initial()) {
    on(_onPlaceFiltersSubscriptionRequested);
    on(_onPlaceListLoadedOrFiltersUpdated);
  }

  Future<void> _onPlaceFiltersSubscriptionRequested(
    PlaceFiltersSubscriptionRequested event,
    Emitter<PlaceListState> emit,
  ) async {
    _placeFiltersInteractor.placeFiltersStream
        .listen((event) => add(_PlaceFiltersUpdated()));
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
    }
  }

  Future<PlaceListState> _getStateWithLoadedData() async {
    final placeFilterRequest = PlacesFilterRequest(
      coordinatePoint: mocked.userCoordinates,
    );

    final places = await _placeInteractor.getFilteredPlaces(
      placeFilterRequest,
      useSavedFilters: true,
      sortByDistance: true,
      addFavouriteMark: true,
    );

    return state.copyWith(
      status: PlaceListStatus.success,
      places: places,
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);

    Error.throwWithStackTrace(
      error.toString(),
      stackTrace,
    );
  }
}
