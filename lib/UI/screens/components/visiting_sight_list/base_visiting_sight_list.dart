import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/empty_visiting_sight_list/base_empty_visiting_sight_list.dart';
import 'package:places/UI/screens/components/visiting_sight_list/base_visiting_sight_list_state.dart';
import 'package:places/domain/sight.dart';
import 'package:places/providers/visiting_provider.dart';

/// Абстрактный класс [BaseVisitingSightList]. Список посещенных/планируемых к посещению мест.
///
/// Если список пуст, будет отображена соответствующая информация ([BaseEmptyVisitingList]).
///
/// Имеет поля, которые необходимо переопределить в потомках:
/// * [emptyVisitingList] - виджет для отображения пустого списка.
/// * [sightCardType] - тип карточки достопримечательности.
///
/// Имеет параметры
/// * [listOfSights] - список достопримечательностей.
/// * [viewModel] - вьюмодель для работы со списком мест.
abstract class BaseVisitingSightList extends StatefulWidget {
  final List<Sight> listOfSights;
  abstract final BaseEmptyVisitingList emptyVisitingList;
  abstract final Type sightCardType;
  final VisitingProvider viewModel;

  const BaseVisitingSightList({
    Key? key,
    required this.listOfSights,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<BaseVisitingSightList> createState() => BaseVisitingSightListState();

  /// Удаляет достопримечательность из списка.
  void deleteSightFromList(Sight sight);

  /// Вставляет нужную карточку места по заданному индексу.
  void insertIntoSightList(
    int destinationIndex,
    int sightIndex,
    BuildContext context,
  );
}
