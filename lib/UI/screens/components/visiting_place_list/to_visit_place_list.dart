import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/empty_visiting_place_list/base_empty_visiting_place_list.dart';
import 'package:places/UI/screens/components/empty_visiting_place_list/empty_to_visit_place_list.dart';
import 'package:places/UI/screens/components/place_card/to_visit_place_card.dart';
import 'package:places/UI/screens/components/visiting_place_list/base_visiting_place_list.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/providers/visiting_provider.dart';

/// Список планируемых к посещению мест. Наследуется от [BaseVisitingPlaceList].
///
/// Если список пуст, будет отображена соответствующая информация ([EmptyToVisitPlaceList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [placeCardType] - тип карточки места.
class ToVisitPlaceList extends BaseVisitingPlaceList {
  @override
  late final BaseEmptyVisitingList emptyVisitingList;

  @override
  late final Type placeCardType;

  ToVisitPlaceList(
    VisitingProvider viewModel, {
    Key? key,
  }) : super(
          listOfPlaces: viewModel.toVisitPlaces,
          viewModel: viewModel,
          key: key,
        ) {
    emptyVisitingList = const EmptyToVisitPlaceList();
    placeCardType = ToVisitPlaceCard;
  }

  @override
  void deletePlaceFromList(Place place) {
    viewModel.deletePlaceFromToVisitList(place);
  }

  @override
  void insertIntoPlaceList(
    int destinationIndex,
    int placeIndex,
    BuildContext context,
  ) {
    viewModel.insertIntoToVisitPlaceList(destinationIndex, placeIndex);
  }
}
