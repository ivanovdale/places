import 'package:places/domain/model/place.dart';

extension PlaceListExt on List<Place> {
  /// Возвращает список мест, планируемых к посещению.
  List<Place> filterByNotVisited() {
    return where((place) => !place.visited).toList();
  }

  /// Возвращает список посещенных мест.
  List<Place> filterByVisited() {
    return where((place) => place.visited).toList();
  }
}
