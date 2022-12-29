import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_search_interactor.dart';
import 'package:places/data/repository/place_repository.dart';

/// Провайдер для интерактора.
///
/// В конструктор передаётся репозиторий, с которым работает интерактор.
class PlaceSearchInteractorProvider extends ChangeNotifier {
  /// Интерактор для работы с поиском мест.
  final PlaceSearchInteractor placeSearchInteractor;

  PlaceSearchInteractorProvider(PlaceRepository placeRepository)
      : placeSearchInteractor = PlaceSearchInteractor(placeRepository);
}
