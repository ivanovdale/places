import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/sight_details_screen.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/utils/visiting_date_formatter.dart';

/// Абстрактный класс [BaseSightCard]. Отображает краткую информацию о месте.
///
/// Имеет поля, которые необходимо переопределить в потомках:
/// * [actions] - список действий с карточкой. Список мап, содержащих картинку и коллбэк.
/// * [showDetails] - признак отображения детальной информации (краткого описания) места.
///
/// Параметры:
/// * [sight] - модель достопримечательности.
abstract class BaseSightCard extends StatelessWidget {
  final Sight sight;
  abstract final bool showDetails;
  abstract final List<Map<String, Object?>> actions;

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
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => _showSightDetailsBottomSheet(context, sight),
            child: Column(
              children: [
                Expanded(
                  child: _SightCardTop(
                    sight,
                    actions,
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

  /// Показывает боттомшит детализации достопримечательности.
  void _showSightDetailsBottomSheet(BuildContext context, Sight sight) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => SightDetailsScreen(sight.id),
    );
  }
}

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

/// Виджет верхняя часть карточки достопримечательности.
///
/// Содержит картинку и тип места.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности;
/// * [actions] - список действий с карточкой.
class _SightCardTop extends StatelessWidget {
  final Sight sight;
  final List<Map<String, Object?>> actions;

  const _SightCardTop(
    this.sight,
    this.actions, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSecondaryColor = theme.colorScheme.onSecondary;

    /// Картинка по умолчанию.
    const defaultImageUrl =
        'https://wallbox.ru/resize/1024x768/wallpapers/main2/201726/pole12.jpg';

    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: sight.photoUrlList?[0] ?? defaultImageUrl,
          imageBuilder: (context, imageProvider) {
            return Ink.image(
              image: imageProvider,
              fit: BoxFit.cover,
            );
          },
          placeholder: (context, url) => const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
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
                style: theme.textTheme.bodyText2?.copyWith(
                  color: onSecondaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 18,
                top: 19,
              ),
              // Действия с карточкой.
              child: _SightActions(actions),
            ),
          ],
        ),
      ],
    );
  }
}

/// Список кнопок для работы с карточкой.
///
/// Параметр:
/// * [actions] - список действий с карточкой.
class _SightActions extends StatelessWidget {
  final List<Map<String, Object?>> actions;

  const _SightActions(
    this.actions, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: actions.map((action) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
          ),
          child: InkWell(
            child: SvgPicture.asset(action['icon'] as String),
            onTap: (action['voidCallback'] as VoidCallback?) ??
                () {
                  // TODO(daniiliv): Здесь будет реальный вызов.
                  if (kDebugMode) {
                    print(
                      '"${(action['icon'] as String).split('/')[2].replaceAll('.svg', '')}" button pressed.',
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
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
      ),
      child: Ink(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Text(
                sight.name,
                style: theme.textTheme.button,
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
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Text(
        sight.details,
        maxLines: 2,
        style: theme.textTheme.bodyText2?.copyWith(
          color: secondaryColor,
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final secondaryColor = theme.colorScheme.secondary;
    final themeBodyText2 = theme.textTheme.bodyText2;

    final visitingText =
        sight.visited ? AppStrings.placeVisited : AppStrings.planToVisit;
    final visitDateFormatted =
        VisitingDateFormatter.getFormattedString(visitingText, sight.visitDate);

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
            visitDateFormatted,
            maxLines: 2,
            style: themeBodyText2?.copyWith(
              color:
                  sight.visited ? colorScheme.secondary : colorScheme.primary,
            ),
          ),
          const Spacer(),
          Text(
            '${AppStrings.closedTo} ${sight.workTimeFrom}',
            style: themeBodyText2?.copyWith(
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
