import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/empty_visiting_sight_list/base_empty_visiting_sight_list.dart';
import 'package:places/UI/screens/components/empty_visiting_sight_list/empty_visited_sight_list.dart';
import 'package:places/UI/screens/components/sight_card/visited_sight_card.dart';
import 'package:places/UI/screens/components/visiting_sight_list/base_visiting_sight_list.dart';
import 'package:places/data/model/sight.dart';
import 'package:places/providers/visiting_provider.dart';

/// Список посещенных мест. Наследуется от [BaseVisitingSightList].
///
/// Если список пуст, будет отображена соответствующая информация ([EmptyVisitedSightList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [sightCardType] - тип карточки достопримечательности.
class VisitedSightList extends BaseVisitingSightList {
  @override
  late final BaseEmptyVisitingList emptyVisitingList;

  @override
  late final Type sightCardType;

  VisitedSightList(
    VisitingProvider viewModel, {
    Key? key,
  }) : super(
          listOfSights: viewModel.visitedSights,
          viewModel: viewModel,
          key: key,
        ) {
    emptyVisitingList = const EmptyVisitedSightList();
    sightCardType = VisitedSightCard;
  }

  @override
  void deleteSightFromList(Sight sight) {
    viewModel.deleteSightFromVisitedList(sight);
  }

  @override
  void insertIntoSightList(
    int destinationIndex,
    int sightIndex,
    BuildContext context,
  ) {
    viewModel.insertIntoVisitedSightList(destinationIndex, sightIndex);
  }
}
