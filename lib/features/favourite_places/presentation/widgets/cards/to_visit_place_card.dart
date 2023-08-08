import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/presentation/widgets/place_card/base_place_card.dart';

/// Виджет карточки места, которую планируется посетить. Наследуется от [BasePlaceCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 2 элемента - кнопка удаления из избранного, кнопка календаря.
///
/// Также переопределяет поле [showDetails] - для отображения информации о планируемом посещении места.
///
/// Имеет параметры:
/// * [place] - модель места (обязательный).
class ToVisitPlaceCard extends BasePlaceCard {
  @override
  final Widget actions;

  @override
  bool get showDetails => false;

  ToVisitPlaceCard(
    super.place, {
    VoidCallback? onCalendarPressed,
    VoidCallback? onDeletePressed,
    super.key,
  })  : actions = _PlaceActions(
          onCalendarPressed: onCalendarPressed,
          onDeletePressed: onDeletePressed,
        );
}

/// Список кнопок для работы с карточкой.
class _PlaceActions extends StatelessWidget {
  final VoidCallback? onCalendarPressed;
  final VoidCallback? onDeletePressed;

  const _PlaceActions({
    this.onCalendarPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final actionButtons = [
      InkWell(
        child: SvgPicture.asset(AppAssets.calendar),
        onTap: onCalendarPressed,
      ),
      InkWell(
        child: SvgPicture.asset(AppAssets.close),
        onTap: onDeletePressed,
      ),
    ];

    return Row(
      children: actionButtons.map((action) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 18,
          ),
          child: action,
        );
      }).toList(),
    );
  }
}
