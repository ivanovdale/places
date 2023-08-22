import 'dart:async';

import 'package:places/core/domain/model/place.dart';

typedef PlaceFilters = ({Set<PlaceTypes> types, double radius});

abstract interface class PlaceFiltersRepository {
  Stream<PlaceFilters> get placeFilters;

  FutureOr<bool> save(PlaceFilters placeFilters);

  void dispose();
}
