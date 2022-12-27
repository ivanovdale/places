import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/empty_visiting_place_list/base_empty_visiting_place_list.dart';
import 'package:places/UI/screens/components/empty_visiting_place_list/empty_visited_place_list.dart';
import 'package:places/UI/screens/components/place_card/visited_place_card.dart';
import 'package:places/UI/screens/components/visiting_place_list/base_visiting_place_list.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/providers/visiting_provider.dart';

/// Список посещенных мест. Наследуется от [BaseVisitingPlaceList].
///
/// Если список пуст, будет отображена соответствующая информация ([EmptyVisitedPlaceList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [placeCardType] - тип карточки места.
class VisitedPlaceList extends BaseVisitingPlaceList {
  @override
  late final BaseEmptyVisitingList emptyVisitingList;

  @override
  late final Type placeCardType;

  VisitedPlaceList(
    VisitingProvider viewModel, {
    Key? key,
  }) : super(
          listOfPlaces: viewModel.visitedPlaces,
          viewModel: viewModel,
          key: key,
        ) {
    emptyVisitingList = const EmptyVisitedPlaceList();
    placeCardType = VisitedPlaceCard;
  }

  @override
  void deletePlaceFromList(Place place) {
    viewModel.removeFromFavorites(place);
  }

  @override
  void insertIntoPlaceList(
    int destinationIndex,
    int placeIndex,
    BuildContext context,
  ) {
    viewModel.insertIntoVisitedPlaceList(destinationIndex, placeIndex);
  }
}
