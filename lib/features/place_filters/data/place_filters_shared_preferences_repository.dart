import 'dart:async';

import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_constants.dart';
import 'package:places/core/helpers/shared_prefs_keys.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class PlaceFiltersSharedPreferencesRepository
    implements PlaceFiltersRepository {
  final SharedPreferences _sharedPreferences;
  final StreamController<PlaceFilters> _placeFiltersStreamController;

  @override
  Stream<PlaceFilters> get placeFiltersStream =>
      _placeFiltersStreamController.stream.asBroadcastStream();

  @override
  PlaceFilters get placeFilters => _getPlaceFiltersFromSharedPreferences();

  PlaceFiltersSharedPreferencesRepository({
    required SharedPreferences sharedPreferences,
  })  : _sharedPreferences = sharedPreferences,
        _placeFiltersStreamController = BehaviorSubject<PlaceFilters>() {
    _initialize();
  }

  void _initialize() {
    _placeFiltersStreamController.add(placeFilters);
  }

  PlaceFilters _getPlaceFiltersFromSharedPreferences() {
    var types = _sharedPreferences
        .getStringList(SharedPrefsKeys.types)
        ?.map(PlaceTypes.fromString);
    types ??= PlaceTypes.values;

    final radius = _sharedPreferences.getDouble(SharedPrefsKeys.radius) ??
        AppConstants.maxRangeValue;

    return (
      types: types.toSet(),
      radius: radius,
    );
  }

  @override
  Future<bool> save(PlaceFilters placeFilters) async {
    var isSaved = false;
    isSaved = await _sharedPreferences.setStringList(
      SharedPrefsKeys.types,
      placeFilters.types.map((type) => type.name).toList(),
    );
    isSaved = await _sharedPreferences.setDouble(
      SharedPrefsKeys.radius,
      placeFilters.radius,
    );

    if (isSaved) _placeFiltersStreamController.add(placeFilters);

    return isSaved;
  }
}
