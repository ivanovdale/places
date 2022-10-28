import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart' as mocked;

/// Вьюмодель для экрана планируемых к посещению/посещённых мест.
class VisitingProvider extends ChangeNotifier {
  // TODO(daniiliv): Инициализация мест из моковых данных.
  List<Sight> toVisitSights = mocked.sights
      .where(
        (element) => !element.visited,
      )
      .toList();

  List<Sight> visitedSights = mocked.sights
      .where(
        (element) => element.visited,
      )
      .toList();

  /// Удаляет достопримечательность из списка планируемых к посещению.
  void deleteSightFromToVisitList(Sight sight) {
    toVisitSights.remove(sight);

    notifyListeners();
  }

  /// Удаляет достопримечательность из списка посещенных.
  void deleteSightFromVisitedList(Sight sight) {
    visitedSights.remove(sight);
    notifyListeners();
  }

  /// Вставляет нужную карточку места  по заданному индексу.
  void insertIntoToVisitSightList(int destinationIndex, int sightIndex) {
    final sight = toVisitSights[sightIndex];
    toVisitSights
      ..removeAt(sightIndex)
      ..insert(destinationIndex, sight);

    notifyListeners();
  }

  /// Вставляет нужную карточку места по заданному индексу.
  void insertIntoVisitedSightList(int destinationIndex, int sightIndex) {
    final sight = visitedSights[sightIndex];
    visitedSights
      ..removeAt(sightIndex)
      ..insert(destinationIndex, sight);
    notifyListeners();
  }

  /// Обновляет дату желаемого посещения достопримечательности.
  void updateToVisitSightDateTime(int id, DateTime dateTime) {
    toVisitSights.firstWhere((sight) => sight.id == id).visitDate = dateTime;

    notifyListeners();
  }
}
