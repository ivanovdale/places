import 'package:places/core/domain/model/place.dart';

abstract interface class FavouritePlaceRepository {
  List<Place> getPlaces();

  List<Place> toggleFavourite(Place place);

  List<Place> insertPlace(
    Place place,
    Place targetPlace,
  );
}
