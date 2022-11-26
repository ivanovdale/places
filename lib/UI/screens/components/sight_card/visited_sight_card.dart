import 'package:flutter/foundation.dart';
import 'package:places/UI/screens/components/sight_card/base_sight_card.dart';
import 'package:places/data/model/sight.dart';
import 'package:places/helpers/app_assets.dart';

/// Виджет карточки посещённой достопримечательности. Наследуется от [BaseSightCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 2 элемента - кнопка удаления из избранного, кнопка календаря.
///
/// Также переопределяет поле [showDetails] - для отображения информации о посещенном месте.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности (обязательный);
class VisitedSightCard extends BaseSightCard {
  final VoidCallback? onSharePressed;
  final VoidCallback? onDeletePressed;

  @override
  late final List<Map<String, Object?>> actions;

  @override
  bool get showDetails => false;

  VisitedSightCard(
    Sight sight, {
    this.onSharePressed,
    this.onDeletePressed,
    Key? key,
  }) : super(
          sight,
          key: key,
        ) {
    actions = [
      {
        'icon': AppAssets.share,
        'voidCallback': onSharePressed,
      },
      {
        'icon': AppAssets.close,
        'voidCallback': onDeletePressed,
      },
    ];
  }
}
