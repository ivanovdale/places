import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/presentation/widgets/place_card/base_place_card.dart';

/// Виджет карточки посещённого места. Наследуется от [BasePlaceCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 2 элемента - кнопка удаления из избранного, кнопка "поделиться".
///
/// Также переопределяет поле [showDetails] - для отображения информации о посещенном месте.
///
/// Имеет параметры:
/// * [place] - модель места (обязательный).
class VisitedPlaceCard extends BasePlaceCard {
  @override
  final Widget actions;

  @override
  bool get showDetails => false;

  VisitedPlaceCard(
    super.place, {
    VoidCallback? onDeletePressed,
    VoidCallback? onSharePressed,
    super.key,
  }) : actions = _PlaceActions(
          onSharePressed: onSharePressed,
          onDeletePressed: onDeletePressed,
        );
}

/// Список кнопок для работы с карточкой.
class _PlaceActions extends StatelessWidget {
  final VoidCallback? onSharePressed;
  final VoidCallback? onDeletePressed;

  const _PlaceActions({
    required this.onSharePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final actionButtons = [
      InkWell(
        borderRadius: BorderRadius.circular(50),
        child: SvgPicture.asset(AppAssets.share),
        onTap: onSharePressed,
      ),
      InkWell(
        borderRadius: BorderRadius.circular(50),
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
