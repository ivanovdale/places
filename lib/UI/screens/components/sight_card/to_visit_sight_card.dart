import 'package:flutter/foundation.dart';
import 'package:places/UI/screens/components/sight_card/base_sight_card.dart';
import 'package:places/data/model/sight.dart';
import 'package:places/helpers/app_assets.dart';

/// Виджет карточки достопримечательности, которую планируется посетить. Наследуется от [BaseSightCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 2 элемента - кнопка удаления из избранного, кнопка календаря.
/// Также переопределяет поле [showDetails] - для отображения информации о планируемом посещении места.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности (обязательный);
class ToVisitSightCard extends BaseSightCard {
  final VoidCallback? onCalendarPressed;
  final VoidCallback? onDeletePressed;

  @override
  late final List<Map<String, Object?>> actions;

  @override
  bool get showDetails => false;

  ToVisitSightCard(
      Sight sight, {
        this.onCalendarPressed,
        this.onDeletePressed,
        Key? key,
      }) : super(
    sight,
    key: key,
  ) {
    actions = [
      {
        'icon': AppAssets.calendar,
        'voidCallback': onCalendarPressed,
      },
      {
        'icon': AppAssets.close,
        'voidCallback': onDeletePressed,
      },
    ];
  }
}