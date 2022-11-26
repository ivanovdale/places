import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/sight_card/base_sight_card.dart';
import 'package:places/data/model/sight.dart';
import 'package:places/helpers/app_assets.dart';

/// Виджет карточки достопримечательности. Наследуется от [BaseSightCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 1 элемент - кнопка добавления в избранное.
/// Также переопределяет поле [showDetails] - для отображения детальной информации о достопримечательности.
///
/// Отображает краткую информацию о месте.
///
/// Параметры:
/// * [sight] - модель достопримечательности (обязательный);
class SightCard extends BaseSightCard {
  @override
  final List<Map<String, Object?>> actions = [
    {
      'icon': AppAssets.heart,
    },
  ];

  @override
  bool get showDetails => true;

  SightCard(
    Sight sight, {
    Key? key,
  }) : super(
          sight,
          key: key,
        );
}
