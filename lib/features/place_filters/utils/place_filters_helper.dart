import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_constants.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';

abstract final class PlaceFiltersHelper {
  static PlaceFilters getDefaults() => (
        types: PlaceTypes.values.toSet(),
        radius: AppConstants.maxRangeValue,
      );
}
