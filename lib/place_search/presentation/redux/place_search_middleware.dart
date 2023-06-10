import 'package:places/data/interactor/place_search_interactor.dart';
import 'package:places/place_search/presentation/redux/place_search_actions.dart';
import 'package:places/place_search/presentation/redux/place_search_state.dart';
import 'package:redux/redux.dart';

class PlaceSearchMiddleware implements MiddlewareClass<PlaceSearchState> {
  final PlaceSearchInteractor _placeSearchInteractor;

  PlaceSearchMiddleware(this._placeSearchInteractor);

  @override
  Future<void> call(
    Store<PlaceSearchState> store,
    // ignore: avoid_annotating_with_dynamic
    dynamic action,
    NextDispatcher next,
  ) async {
    if (action is MakeSearch) {
      store.dispatch(
        MakeSearchInProgress(),
      );

      final placeSearchState = store.state;
      _placeSearchInteractor.setFilters(
        typeFilter: placeSearchState.placeTypeFilters,
        radius: placeSearchState.radius,
        userCoordinates: placeSearchState.userCoordinates,
      );

      final placesFound = await _placeSearchInteractor.getFilteredPlaces(
        action.searchQuery,
      );

      store.dispatch(
        MakeSearchResult(
          placesFound,
        ),
      );
    }

    next(action);
  }
}
