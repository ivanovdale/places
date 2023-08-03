import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';
import 'package:places/features/place_filters/presentation/place_filters_screen.dart';
import 'package:places/mocks.dart' as mocked;

part 'place_list_store.g.dart';

class PlaceListStore = PlaceListStoreBase with _$PlaceListStore;

abstract class PlaceListStoreBase with Store {
  final PlaceInteractor placeInteractor;

  @observable
  ObservableFuture<List<Place>>? placesFuture;

  double get radius => _radius;

  Set<PlaceTypes> get placeTypeFilters => _placeTypeFilters;

  /// Фильтры мест.
  Set<PlaceTypes> _placeTypeFilters = PlaceTypes.values.toSet();

  /// Радиус поиска.
  double _radius = maxRangeValue;

  PlaceListStoreBase(this.placeInteractor);

  @action
  Future<void> getFilteredPlaces() async {
    final placeFilterRequest = PlacesFilterRequest(
      coordinatePoint: mocked.userCoordinates,
      radius: _radius,
      typeFilter: _placeTypeFilters.toList(),
    );

    final future = placeInteractor.getFilteredPlaces(placeFilterRequest);
    placesFuture = ObservableFuture<List<Place>>(future);
  }

  void saveFilters(Set<PlaceTypes> placeTypeFilters, double radius) {
    _placeTypeFilters = placeTypeFilters;
    _radius = radius;
  }
}
