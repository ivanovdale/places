import 'package:places/core/data/source/database/database.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/favourite_places/data/mapper/favourite_mapper.dart';
import 'package:places/features/favourite_places/domain/repository/favourite_place_repository.dart';

final class FavouritePlaceDataRepository implements FavouritePlaceRepository {
  const FavouritePlaceDataRepository({
    required Database database,
  }) : _database = database;

  final Database _database;

  @override
  Stream<List<Place>> getFavourites() =>
      _database.getFavourites().map((favourite) => favourite.toModelList());

  @override
  Future<void> toggleFavourite(Place place) async {
    final placeId = place.id!;
    final isFavorite = await _database
        .getFavouriteById(placeId)
        .then((value) => value != null);

    return isFavorite
        ? _database.deleteFavourite(placeId)
        : _database.addToFavourites(place.toCompanion());
  }

  @override
  Future<void> updateFavouriteVisited(int id, {required bool visited}) =>
      _database.updateFavouriteVisited(
        id,
        visited ? 1 : 0,
      );

  @override
  Future<void> updateFavouriteDate(int id, DateTime date) =>
      _database.updateFavouriteDate(
        id,
        date.toUtc().millisecondsSinceEpoch,
      );

  @override
  Future<void> updateFavouritePosition(int id, int position) =>
      _database.updateFavouritePosition(id, position);
}
