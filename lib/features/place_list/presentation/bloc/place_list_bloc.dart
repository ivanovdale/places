import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/data/interactor/place_interactor.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/domain/model/places_filter_request.dart';
import 'package:places/core/helpers/app_constants.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';
import 'package:places/mocks.dart' as mocked;

part 'place_list_event.dart';

part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final PlaceInteractor _placeInteractor;

  PlaceListBloc(this._placeInteractor) : super(PlaceListState.initial()) {
    on(_onPlaceListLoaded);
  }

  Future<void> _onPlaceListLoaded(
    PlaceListEvent event,
    Emitter<PlaceListState> emit,
  ) async {
    final isLoadedWithFilters = event is PlaceListWithFiltersLoaded;

    emit(
      state.copyWith(
        status: PlaceListStatus.loading,
      ),
    );

    if (isLoadedWithFilters) {
      emit(
        state.copyWith(placeFilters: event.placeFilters),
      );
    }

    final placeFilterRequest = PlacesFilterRequest(
      coordinatePoint: mocked.userCoordinates,
      radius: state.placeFilters.radius,
      typeFilter: state.placeFilters.types.toList(),
    );
    try {
      final places =
          await _placeInteractor.getFilteredPlaces(placeFilterRequest);

      final newState = state.copyWith(
        status: PlaceListStatus.success,
        places: places,
      );

      emit(newState);
    } on Exception catch (error, stackTrace) {
      emit(
        state.copyWith(
          status: PlaceListStatus.failure,
        ),
      );

      Error.throwWithStackTrace(
        error.toString(),
        stackTrace,
      );
    }
  }
}
