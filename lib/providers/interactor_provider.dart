import 'package:flutter/material.dart';
import 'package:places/API/dio_api.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/network_place_repository.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/place.dart';

/// Провайдер для интерактора.
class InteractorProvider extends ChangeNotifier {
  /// Репозиторий, с которым работает интерактор.
  static final PlaceRepository _placeRepository =
      NetworkPlaceRepository(DioApi());
  PlaceInteractor placeInteractor = PlaceInteractor(_placeRepository);

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
