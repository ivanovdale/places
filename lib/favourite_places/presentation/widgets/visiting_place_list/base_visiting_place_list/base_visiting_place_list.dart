import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/favourite_places/presentation/widgets/visiting_place_list/base_visiting_place_list/base_visiting_place_list_state.dart';


typedef OnPlaceInserted = Function(Place, Place);
typedef OnPlaceDeleted = Function(Place);

/// Абстрактный класс [BaseVisitingPlaceList]. Список посещенных/планируемых к посещению мест.
///
/// Если список пуст, будет отображена соответствующая информация ([emptyVisitingList]).
///
/// Имеет поля, которые необходимо переопределить в потомках:
/// * [emptyVisitingList] - виджет для отображения пустого списка.
/// * [placeCardType] - тип карточки места.
///
/// Имеет параметры
/// * [listOfPlaces] - список мест.
abstract class BaseVisitingPlaceList extends StatefulWidget {
  final List<Place> listOfPlaces;
  abstract final WidgetBuilder emptyVisitingList;
  abstract final Type placeCardType;

  final OnPlaceInserted? onPlaceInserted;
  final OnPlaceDeleted? onPlaceDeleted;

  const BaseVisitingPlaceList({
    Key? key,
    required this.listOfPlaces,
    this.onPlaceInserted,
    this.onPlaceDeleted,
  }) : super(key: key);

  @override
  State<BaseVisitingPlaceList> createState() => BaseVisitingPlaceListState();

  /// Удаляет места из списка.
  void deletePlaceFromList(Place place);

  /// Вставляет нужную карточку места по заданному индексу.
  void insertIntoPlaceList(
    int destinationIndex,
    int placeIndex,
    BuildContext context,
  );
}
