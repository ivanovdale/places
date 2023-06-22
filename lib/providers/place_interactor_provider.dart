import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/repository/place_repository.dart';
import 'package:places/features/favourite_places/domain/favourite_place_repository.dart';

/// Провайдер для интерактора.
///
/// В конструктор передаётся репозиторий, с которым работает интерактор.
class PlaceInteractorProvider {
  /// Интерактор для работы с местами.
  final PlaceInteractor placeInteractor;

  PlaceInteractorProvider({
    required PlaceRepository placeRepository,
    required FavouritePlaceRepository favouritePlaceRepository,
  }) : placeInteractor = PlaceInteractor(
          placeRepository: placeRepository,
          favouritePlaceRepository: favouritePlaceRepository,
        );
}
