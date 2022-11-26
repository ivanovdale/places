import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart' as mocked;

/// Вьюмодель для экрана планируемых к посещению/посещённых мест.
class VisitingProvider extends ChangeNotifier {
  // TODO(daniiliv): Инициализация мест из моковых данных.
  List<Place> toVisitPlaces = mocked.places
      .where(
        (element) => !element.visited,
      )
      .toList();

  List<Place> visitedPlaces = mocked.places
      .where(
        (element) => element.visited,
      )
      .toList();

  /// Удаляет место из списка планируемых к посещению.
  void deletePlaceFromToVisitList(Place place) {
    toVisitPlaces.remove(place);

    notifyListeners();
  }

  /// Удаляет место из списка посещенных.
  void deletePlaceFromVisitedList(Place place) {
    visitedPlaces.remove(place);
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
