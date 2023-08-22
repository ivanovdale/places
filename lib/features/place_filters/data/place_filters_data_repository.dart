import 'dart:async';

import 'package:places/core/domain/model/place.dart';
import 'package:places/core/domain/storage/key_value_storage.dart';
import 'package:places/core/helpers/app_constants.dart';
import 'package:places/core/helpers/key_value_storage_keys.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';
import 'package:rxdart/rxdart.dart';

final class PlaceFiltersDataRepository implements PlaceFiltersRepository {
  final KeyValueStorage _keyValueStorage;
  final StreamController<PlaceFilters> _placeFiltersStreamController =
      BehaviorSubject<PlaceFilters>();

  @override
  Stream<PlaceFilters> get placeFilters =>
      _placeFiltersStreamController.stream.asBroadcastStream();

  PlaceFiltersDataRepository({
    required KeyValueStorage keyValueStorage,
  }) : _keyValueStorage = keyValueStorage {
    _initialize();
  }

  Future<void> _initialize() async =>
      _placeFiltersStreamController.add(await _getPlaceFiltersFromStorage());

  @override
  void dispose() => _placeFiltersStreamController.close();

  @override
  Future<bool> save(PlaceFilters placeFilters) async {
    final isTypesSaved = await _keyValueStorage.setStringList(
      KeyValueStorageKeys.types,
      placeFilters.types.map((type) => type.name).toList(),
    );
    final isRadiusSaved = await _keyValueStorage.setDouble(
      KeyValueStorageKeys.radius,
      placeFilters.radius,
    );

    final isFiltersSaved = isTypesSaved && isRadiusSaved;
    if (isFiltersSaved) _placeFiltersStreamController.add(placeFilters);

    return isFiltersSaved;
  }

  Future<PlaceFilters> _getPlaceFiltersFromStorage() async {
    var types =
        (await _keyValueStorage.getStringList(KeyValueStorageKeys.types))
            ?.map(PlaceTypes.fromString);
    types ??= PlaceTypes.values;

    final radius =
        await _keyValueStorage.getDouble(KeyValueStorageKeys.radius) ??
            AppConstants.maxRangeValue;

    return (
      types: types.toSet(),
      radius: radius,
    );
  }
}
