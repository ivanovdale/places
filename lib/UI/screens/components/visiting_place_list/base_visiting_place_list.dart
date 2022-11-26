import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/empty_visiting_place_list/base_empty_visiting_place_list.dart';
import 'package:places/UI/screens/components/visiting_place_list/base_visiting_place_list_state.dart';
import 'package:places/data/model/place.dart';
import 'package:places/providers/visiting_provider.dart';

/// Абстрактный класс [BaseVisitingPlaceList]. Список посещенных/планируемых к посещению мест.
///
/// Если список пуст, будет отображена соответствующая информация ([BaseEmptyVisitingList]).
///
/// Имеет поля, которые необходимо переопределить в потомках:
/// * [emptyVisitingList] - виджет для отображения пустого списка.
/// * [placeCardType] - тип карточки места.
///
/// Имеет параметры
/// * [listOfPlaces] - список мест.
/// * [viewModel] - вьюмодель для работы со списком мест.
abstract class BaseVisitingPlaceList extends StatefulWidget {
  final List<Place> listOfPlaces;
  abstract final BaseEmptyVisitingList emptyVisitingList;
  abstract final Type placeCardType;
  final VisitingProvider viewModel;

  const BaseVisitingPlaceList({
    Key? key,
    required this.listOfPlaces,
    required this.viewModel,
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
