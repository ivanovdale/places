import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';
import 'package:places/helpers/app_constants.dart';
import 'package:rxdart/rxdart.dart';

part 'place_filters_event.dart';

part 'place_filters_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class PlaceFiltersBloc extends Bloc<PlaceFiltersEvent, PlaceFiltersState> {
  final PlaceInteractor _placeInteractor;
  final CoordinatePoint _userCoordinates;

  /// Время активации фильтра по расстоянию до места.
  final _applianceRadiusFilterDelay = const Duration(milliseconds: 500);

  PlaceFiltersBloc({
    required PlaceInteractor placeInteractor,
    required CoordinatePoint userCoordinates,
  })  : _placeInteractor = placeInteractor,
        _userCoordinates = userCoordinates,
        super(PlaceFiltersState.initial()) {
    on(_onPlaceFiltersStarted);
    on(_onPlaceFiltersTypeFilterSelected);
    on(_onPlaceFiltersRadiusSelected);
    on(_onPlaceFiltersAllFiltersReset);
    on(_onPlaceFiltersUpdated);
    on(
      _onPlaceFiltersWithDelayUpdated,
      transformer: debounce<_PlaceFiltersWithDelayUpdated>(
        _applianceRadiusFilterDelay,
      ),
    );
  }

  Future<void> _onPlaceFiltersStarted(
    PlaceFiltersStarted event,
    Emitter<PlaceFiltersState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedPlaceTypeFilters: event.selectedPlaceTypeFilters,
        radius: event.radius,
      ),
    );

    add(_PlaceFiltersUpdated());
  }

  Future<void> _onPlaceFiltersTypeFilterSelected(
    PlaceFiltersTypeFilterSelected event,
    Emitter<PlaceFiltersState> emit,
  ) async {
    final placeType = event.placeType;
    final selectedPlaceTypeFilters = {...state.selectedPlaceTypeFilters};
    if (selectedPlaceTypeFilters.contains(placeType)) {
      selectedPlaceTypeFilters.remove(placeType);
    } else {
      selectedPlaceTypeFilters.add(placeType);
    }

    emit(
      state.copyWith(
        selectedPlaceTypeFilters: selectedPlaceTypeFilters,
      ),
    );

    add(_PlaceFiltersUpdated());
  }

  Future<void> _onPlaceFiltersRadiusSelected(
    PlaceFiltersRadiusSelected event,
    Emitter<PlaceFiltersState> emit,
  ) async {
    emit(
      state.copyWith(
        radius: event.radius,
      ),
    );

    add(_PlaceFiltersWithDelayUpdated());
  }

  Future<void> _onPlaceFiltersAllFiltersReset(
    PlaceFiltersAllFiltersReset event,
    Emitter<PlaceFiltersState> emit,
  ) async {
    emit(PlaceFiltersState.initial());

    add(_PlaceFiltersUpdated());
  }

  Future<void> _onPlaceFiltersUpdated(
    _PlaceFiltersUpdated event,
    Emitter<PlaceFiltersState> emit,
  ) async {
    await _emitNewFilteredPlacesAmount(emit);
  }

  Future<void> _onPlaceFiltersWithDelayUpdated(
    _PlaceFiltersWithDelayUpdated event,
    Emitter<PlaceFiltersState> emit,
  ) async {
    await _emitNewFilteredPlacesAmount(emit);
  }

  Future<void> _emitNewFilteredPlacesAmount(
    Emitter<PlaceFiltersState> emit,
  ) async {
    final filteredPlacesAmount =
        await _getFilteredByPlaceTypeAndRadiusPlacesAmount(
      selectedPlaceTypeFilters: state.selectedPlaceTypeFilters,
      radius: state.radius,
    );

    emit(
      state.copyWith(filteredPlacesAmount: filteredPlacesAmount),
    );
  }

  /// Возвращает количество мест после фильтрации по категории и расстоянию.
  Future<int> _getFilteredByPlaceTypeAndRadiusPlacesAmount({
    required double radius,
    required Set<PlaceTypes> selectedPlaceTypeFilters,
  }) async {
    final placeFilterRequest = PlacesFilterRequest(
      coordinatePoint: _userCoordinates,
      radius: radius,
      typeFilter: selectedPlaceTypeFilters.toList(),
    );

    final places = await _placeInteractor.getFilteredPlaces(placeFilterRequest);

    return places.length;
  }
}
