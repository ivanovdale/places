import 'package:places/core/domain/model/place.dart';

abstract interface class FavouritePlaceRepository {
  Stream<List<Place>> getFavourites();

  Future<void> toggleFavourite(Place place);

  Future<void> updateFavouriteVisited(int id, {required bool visited});

  Future<void> updateFavouriteDate(int id, DateTime date);

  Future<void> updateFavouritePosition(int id, int position);
}
