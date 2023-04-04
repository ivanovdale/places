import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/place.dart';

/// Провайдер для интерактора.
///
/// В конструктор передаётся репозиторий, с которым работает интерактор.
class PlaceInteractorProvider extends ChangeNotifier {
  /// Интерактор для работы с местами.
  final PlaceInteractor placeInteractor;

  PlaceInteractorProvider(PlaceRepository placeRepository)
      : placeInteractor = PlaceInteractor(placeRepository);

  /// Добавляет место в избранное и уведомляет слушателей.
  /// Убирает место из избранного и уведомляет слушателей.
  void toggleFavorites(Place place) {
    placeInteractor.toggleFavorites(place);
    notifyListeners();
  }
}
