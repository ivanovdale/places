import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:places/core/data/interactor/place_interactor.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/mocks.dart' as mocked;

class AddPlaceModel extends ElementaryModel {
  final PlaceInteractor placeInteractor;
  final ValueNotifier<List<String>> newPhotoList = ValueNotifier([]);
  final ValueNotifier<PlaceTypes?> placeType = ValueNotifier(null);

  /// Тип достопримечательности по умолчанию.
  PlaceTypes get _defaultPlaceType => PlaceTypes.other;

  /// Режим работы места по умолчанию.
  String get _defaultWorkTimeFrom => '9:00';

  AddPlaceModel({
    required this.placeInteractor,
  });

  // TODO(daniiliv): инициализация списка добавляемых фото моковыми данными.
  void loadPhotos() =>
      newPhotoList.value = mocked.photoCarouselOnAddPlaceScreen;

  // ignore: use_setters_to_change_properties
  void setPlaceType(PlaceTypes placeType) {
    this.placeType.value = placeType;
  }

  /// Добавляет новое фото в список добавляемых фото.
  void addPhotoToList(String photoUrl) {
    newPhotoList.value = [...newPhotoList.value, photoUrl];
  }

  /// Удаляет фото из списка добавляемых фото.
  void deletePhotoFromList(int index) {
    newPhotoList.value = [...newPhotoList.value]..removeAt(index);
  }

  Future<Place> createNewPlace({
    required String name,
    required double lat,
    required double lon,
    required String description,
  }) async {
    final newPlace = Place(
      name: name,
      coordinatePoint: CoordinatePoint(
        lat: lat,
        lon: lon,
      ),
      type: placeType.value ?? _defaultPlaceType,
      details: description,
      workTimeFrom: _defaultWorkTimeFrom,
      photoUrlList: newPhotoList.value,
    );
    await placeInteractor.addNewPlace(newPlace);

    return newPlace;
  }
}
