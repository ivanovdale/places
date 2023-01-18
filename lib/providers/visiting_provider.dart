import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/providers/interactor_provider.dart';

/// Вьюмодель для экрана планируемых к посещению/посещённых мест.
class VisitingProvider extends ChangeNotifier {
  final List<Place> toVisitPlaces;

  final List<Place> visitedPlaces;
  final PlaceInteractorProvider? interactorProvider;

  VisitingProvider(this.interactorProvider)
      : toVisitPlaces =
            interactorProvider?.placeInteractor.getToVisitPlaces() ?? [],
        visitedPlaces =
            interactorProvider?.placeInteractor.getVisitedPlaces() ?? [];

  /// Удаляет место из списка планируемых к посещению.
  void removeFromFavorites(Place place) {
    interactorProvider?.toggleFavorites(place);
    notifyListeners();
  }

  /// Вставляет нужную карточку места  по заданному индексу.
  void insertIntoToVisitPlaceList(int destinationIndex, int placeIndex) {
    final place = toVisitPlaces[placeIndex];
    toVisitPlaces
      ..removeAt(placeIndex)
      ..insert(destinationIndex, place);
    notifyListeners();
  }

  /// Вставляет нужную карточку места по заданному индексу.
  void insertIntoVisitedPlaceList(int destinationIndex, int placeIndex) {
    final place = visitedPlaces[placeIndex];
    visitedPlaces
      ..removeAt(placeIndex)
      ..insert(destinationIndex, place);
    notifyListeners();
  }

  /// Обновляет дату желаемого посещения места.
  void updateToVisitPlaceDateTime(int id, DateTime dateTime) {
    toVisitPlaces.firstWhere((place) => place.id == id).visitDate = dateTime;
    notifyListeners();
  }
}
