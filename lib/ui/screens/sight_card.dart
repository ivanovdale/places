import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';

/// Абстрактный класс [BaseSightCard]. Отображает краткую информацию о месте.
///
/// Имеет поля, которые необходимо переопределить в потомках:
/// * [actionsAssets] - список действий с карточкой.
/// * [showDetails] - признак отображения детальной информации (краткого описания) места.
///
/// Параметры:
/// * [sight] - модель достопримечательности.
abstract class BaseSightCard extends StatelessWidget {
  final Sight sight;
  abstract final bool showDetails;
  abstract final List<String> actionsAssets;

  const BaseSightCard(
    this.sight, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Material(
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (kDebugMode) {
                print('SightCard tapped.');
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: _SightCardTop(
                    sight,
                    actionsAssets,
                  ),
                ),
                Expanded(
                  child: _SightCardBottom(
                    sight,
                    showDetails: showDetails,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Виджет карточки достопримечательности. Наследуется от [BaseSightCard].
///
/// Переопределяет поле [actionsAssets] - в списке кнопок карточки 1 элемент - кнопка добавления в избранное.
/// Также переопределяет поле [showDetails] - для отображения детальной информации о достопримечательности.
///
/// Отображает краткую информацию о месте.
///
/// Параметры:
/// * [sight] - модель достопримечательности (обязательный);
class SightCard extends BaseSightCard {
  @override
  final List<String> actionsAssets = [AppAssets.heart];

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

/// Виджет карточки достопримечательности, которую планируется посетить. Наследуется от [BaseSightCard].
///
/// Переопределяет поле [actionsAssets] - в списке кнопок карточки 2 элемента - кнопка удаления из избранного, кнопка календаря.
/// Также переопределяет поле [showDetails] - для отображения информации о планируемом посещении места.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности (обязательный);
class ToVisitSightCard extends BaseSightCard {
  @override
  final List<String> actionsAssets = [
    AppAssets.calendar,
    AppAssets.close,
  ];

  @override
  bool get showDetails => false;

  ToVisitSightCard(
    Sight sight, {
    Key? key,
  }) : super(
          sight,
          key: key,
        );
}

/// Виджет карточки посещённой достопримечательности. Наследуется от [BaseSightCard].
///
/// Переопределяет поле [actionsAssets] - в списке кнопок карточки 2 элемента - кнопка удаления из избранного, кнопка календаря.
///
/// Также переопределяет поле [showDetails] - для отображения информации о посещенном месте.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности (обязательный);
class VisitedSightCard extends BaseSightCard {
  @override
  final List<String> actionsAssets = [
    AppAssets.share,
    AppAssets.close,
  ];

  @override
  bool get showDetails => false;

  VisitedSightCard(
    Sight sight, {
    Key? key,
  }) : super(
          sight,
          key: key,
        );
}

/// Виджет верхняя часть карточки достопримечательности.
///
/// Содержит картинку и тип места.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности;
/// * [actionsAssets] - список действий с карточкой.
class _SightCardTop extends StatelessWidget {
  final Sight sight;
  final List<String> actionsAssets;

  const _SightCardTop(
    this.sight,
    this.actionsAssets, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Ink.image(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              sight.url,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 16.0,
                ),
                child: Text(
                  sight.type.toString(),
                  style: AppTypography.roboto14Regular.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  top: 19,
                ),
                // Действия с карточкой.
                child: _SightActions(actionsAssets),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Список кнопок для работы с карточкой.
///
/// Параметр:
/// * [actionsAssets] - список действий с карточкой.
class _SightActions extends StatelessWidget {
  final List<String> actionsAssets;

  const _SightActions(
    this.actionsAssets, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: actionsAssets.map((asset) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
          ),
          child: InkWell(
            child: SvgPicture.asset(asset),
            onTap: () {
              // TODO(daniiliv): Здесь будет реальный вызов.
              if (kDebugMode) {
                print(
                  '"${asset.split('/')[2].replaceAll('.svg', '')}" button pressed.',
                );
              }
            },
          ),
        );
      }).toList(),
    );
  }
}

/// Виджет нижняя часть карточки достопримечательности.
///
/// Содержит краткую информацию о месте (Название места, краткое описание).
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности;
/// * [showDetails] - отображать детали места (если стоит false, то будет отображена информация о будущем/произошедшем посещении).
class _SightCardBottom extends StatelessWidget {
  final Sight sight;
  final bool showDetails;

  const _SightCardBottom(
    this.sight, {
    Key? key,
    required this.showDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Ink(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Text(
                sight.name,
                style: AppTypography.roboto16Regular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            // Показывать информацию о достопримечательности.
            if (showDetails)
              Expanded(
                child: _SightDetailsInfo(sight),
              )
            else
              Expanded(
                child: _SightVisitingInfo(sight),
              ),
          ],
        ),
      ),
    );
  }
}

/// Отображает описание достопримечательности.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности.
class _SightDetailsInfo extends StatelessWidget {
  final Sight sight;

  const _SightDetailsInfo(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Text(
        sight.details,
        maxLines: 2,
        style: AppTypography.roboto14Regular.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

/// Отображает информацию о предстоящем/завершенном посещении. Также отображает режим работы достопримечательности.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности.
class _SightVisitingInfo extends StatelessWidget {
  final Sight sight;

  const _SightVisitingInfo(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            sight.visited
                ? '${AppStrings.placeVisited} ${sight.visitDate}'
                : '${AppStrings.planToVisit} ${sight.visitDate}',
            maxLines: 2,
            style: AppTypography.roboto14Regular.copyWith(
              color: sight.visited
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            '${AppStrings.closedTo} ${sight.workTimeFrom}',
            style: AppTypography.roboto14Regular.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
