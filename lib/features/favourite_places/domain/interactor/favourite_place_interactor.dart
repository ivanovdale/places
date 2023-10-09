import 'package:places/core/domain/model/place.dart';
import 'package:places/features/favourite_places/domain/repository/favourite_place_repository.dart';

final class FavouritePlaceInteractor {
  final FavouritePlaceRepository _favouritePlaceRepository;

  FavouritePlaceInteractor({
    required FavouritePlaceRepository favouritePlaceRepository,
  }) : _favouritePlaceRepository = favouritePlaceRepository;

  Stream<List<Place>> getFavourites() =>
      _favouritePlaceRepository.getFavourites();

  Future<void> toggleFavourite(Place place) =>
      _favouritePlaceRepository.toggleFavourite(place);

  Future<void> swapFavouritePosition(Place place, Place targetPlace) async {
    await _favouritePlaceRepository.updateFavouritePosition(
        place.id!, targetPlace.position!);
    await _favouritePlaceRepository.updateFavouritePosition(
        targetPlace.id!, place.position!);
  }

  Future<void> updateFavouriteDate(Place place, DateTime date) =>
      _favouritePlaceRepository.updateFavouriteDate(
        place.id!,
        date,
      );

  /// Обновляет флаг посещения места.
  ///
  /// Если место не в избранном, то сначала добавляет его в список избранного.
  /// Дата посещения - текущая дата.
  Future<void> updateFavouriteVisited(
    Place place, {
    required bool visited,
  }) async {
    final isFavourite = await _favouritePlaceRepository
        .getFavouritePlaceById(place.id!)
        .then((value) => value != null);

    if (!isFavourite) {
      await _favouritePlaceRepository.addToFavourites(place);
    }
    await _favouritePlaceRepository.updateFavouriteDate(
      place.id!,
      DateTime.now(),
    );

    return _favouritePlaceRepository.updateFavouriteVisited(
      place.id!,
      visited: visited,
    );
  }
}
