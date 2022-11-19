import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/empty_visiting_sight_list/base_empty_visiting_sight_list.dart';
import 'package:places/UI/screens/components/empty_visiting_sight_list/empty_to_visit_sight_list.dart';
import 'package:places/UI/screens/components/visiting_sight_list/base_visiting_sight_list.dart';
import 'package:places/domain/sight.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:places/ui/screens/components/sight_card.dart';

/// Список планируемых к посещению мест. Наследуется от [BaseVisitingSightList].
///
/// Если список пуст, будет отображена соответствующая информация ([EmptyToVisitSightList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [sightCardType] - тип карточки достопримечательности.
class ToVisitSightList extends BaseVisitingSightList {
  @override
  late final BaseEmptyVisitingList emptyVisitingList;

  @override
  late final Type sightCardType;

  ToVisitSightList(
    VisitingProvider viewModel, {
    Key? key,
  }) : super(
          listOfSights: viewModel.toVisitSights,
          viewModel: viewModel,
          key: key,
        ) {
    emptyVisitingList = const EmptyToVisitSightList();
    sightCardType = ToVisitSightCard;
  }

  @override
  void deleteSightFromList(Sight sight) {
    viewModel.deleteSightFromToVisitList(sight);
  }

  @override
  void insertIntoSightList(
    int destinationIndex,
    int sightIndex,
    BuildContext context,
  ) {
    viewModel.insertIntoToVisitSightList(destinationIndex, sightIndex);
  }
}
