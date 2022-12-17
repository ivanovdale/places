import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_search_interactor.dart';
import 'package:places/data/repository/place_repository.dart';

/// Провайдер для интерактора.
class PlaceSearchInteractorProvider extends ChangeNotifier {
  /// Интерактор для работы с поиском мест.
  late final PlaceSearchInteractor placeSearchInteractor;

  /// Репозиторий, с которым работает интерактор.
  late final PlaceRepository _placeRepository;

  PlaceSearchInteractorProvider(this._placeRepository) {
    placeSearchInteractor = PlaceSearchInteractor(_placeRepository);
  }
}
