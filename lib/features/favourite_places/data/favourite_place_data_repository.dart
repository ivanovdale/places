import 'package:places/domain/model/place.dart';
import 'package:places/features/favourite_places/domain/favourite_place_repository.dart';

// TODO(ivanovdale): Пока данные храним в переменной.
final class FavouritePlaceDataRepository implements FavouritePlaceRepository {
  final List<Place> _places = [];

  @override
  List<Place> getPlaces() {
    return _places;
  }

  @override
  List<Place> toggleFavourite(Place place) {
    final isFavorite = _places.contains(place);
    isFavorite ? _places.remove(place) : _places.add(place);

    return _places;
  }

  @override
  List<Place> insertPlace(
    Place place,
    Place targetPlace,
  ) {
    final index = _places.indexOf(place);
    final targetIndex = _places.indexOf(targetPlace);

    return _places
      ..removeAt(index)
      ..insert(targetIndex, place);
  }
}
