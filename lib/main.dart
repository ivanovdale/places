import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:places/API/dio_api.dart';
import 'package:places/app/app.dart';
import 'package:places/data/interactor/place_search_interactor.dart';
import 'package:places/data/repository/network_place_repository.dart';
import 'package:places/domain/repository/place_repository.dart';
import 'package:places/place_search/presentation/redux/place_search_middleware.dart';
import 'package:places/place_search/presentation/redux/place_search_reducer.dart';
import 'package:places/place_search/presentation/redux/place_search_state.dart';
import 'package:redux/redux.dart';

void main() {
  final networkPlaceRepository = NetworkPlaceRepository(DioApi());
  final store = getReduxStore(networkPlaceRepository);
  GetIt.instance.registerSingleton<PlaceRepository>(networkPlaceRepository);
  GetIt.instance.registerSingleton<Store<PlaceSearchState>>(store);

  runApp(
    const App(),
  );
}

Store<PlaceSearchState> getReduxStore(NetworkPlaceRepository networkPlaceRepository) {
  return Store<PlaceSearchState>(
    placesSearchReducers,
    initialState: PlaceSearchState.initial(),
    middleware: [
      PlaceSearchMiddleware(
        PlaceSearchInteractor(
          networkPlaceRepository,
        ),
      ),
    ],
  );
}
