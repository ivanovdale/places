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

  // TODO(ivanovdale): Будет использовано позже.
  Future<void> updateFavouriteVisited(Place place, {required bool visited}) =>
      _favouritePlaceRepository.updateFavouriteVisited(
        place.id!,
        visited: visited,
      );
}
