import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/place.dart';

/// Провайдер для интерактора.
class PlaceInteractorProvider extends ChangeNotifier {
  /// Интерактор для работы с местами.
  late final PlaceInteractor placeInteractor;

  /// Репозиторий, с которым работает интерактор.
  late final PlaceRepository _placeRepository;

  PlaceInteractorProvider(this._placeRepository) {
    placeInteractor = PlaceInteractor(_placeRepository);
  }

  /// Добавляет место в избранное и уведомляет слушателей.
  void addToFavorites(Place place) {
    placeInteractor.addToFavorites(place);

    notifyListeners();
  }

  /// Убирает место из избранного и уведомляет слушателей.
  void removeFromFavorites(Place place) {
    placeInteractor.removeFromFavorites(place);

    notifyListeners();
  }
}
