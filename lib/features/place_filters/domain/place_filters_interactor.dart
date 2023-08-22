import 'dart:async';

import 'package:places/features/place_filters/domain/place_filters_repository.dart';

final class PlaceFiltersInteractor {
  final PlaceFiltersRepository _placeFiltersRepository;

  Stream<PlaceFilters> get placeFilters => _placeFiltersRepository.placeFilters;

  const PlaceFiltersInteractor({
    required PlaceFiltersRepository placeFiltersRepository,
  }) : _placeFiltersRepository = placeFiltersRepository;

  FutureOr<bool> saveFilters(PlaceFilters placeFilters) {
    return _placeFiltersRepository.save(placeFilters);
  }
}
