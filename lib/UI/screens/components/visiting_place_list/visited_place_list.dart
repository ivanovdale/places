import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/place_card/visited_place_card.dart';
import 'package:places/UI/screens/components/placeholders/empty_visited_placeholder.dart';
import 'package:places/UI/screens/components/placeholders/info_placeholder.dart';
import 'package:places/UI/screens/components/visiting_place_list/base_visiting_place_list.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/providers/visiting_provider.dart';

/// Список посещенных мест. Наследуется от [BaseVisitingPlaceList].
///
/// Если список пуст, будет отображена соответствующая информация ([emptyVisitingList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [placeCardType] - тип карточки места.
class VisitedPlaceList extends BaseVisitingPlaceList {
  @override
  final InfoPlaceHolder emptyVisitingList;

  @override
  final Type placeCardType;

  VisitedPlaceList(
    VisitingProvider viewModel, {
    Key? key,
  })  : emptyVisitingList = const EmptyVisitedPlaceHolder(),
        placeCardType = VisitedPlaceCard,
        super(
          listOfPlaces: viewModel.visitedPlaces,
          viewModel: viewModel,
          key: key,
        );

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
