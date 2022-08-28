import 'package:flutter/cupertino.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/ui/screen/components/loading_indicator.dart';

/// Виджет карточки достопримечательности.
///
/// Отображает краткую информацию о месте.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности (обязательный);
/// * [showDetails] - отображать детали места (если стоит false, то будет отображена информация о будущем/произошедшем посещении);
/// * [enableToFavouritesButton] - признак отображения кнопки добавления в избранное;
/// * [enableRemoveFromFavouritesButton] - признак отображения кнопки удаления из избранного;
/// * [enableCalendarButton] - признак отображения картинки календаря (запланировано к посещению);
/// * [enableShareButton] - признак отображения кнопки "поделиться".
class SightCard extends StatelessWidget {
  final Sight sight;
  final bool showDetails;
  final bool enableToFavouritesButton;
  final bool enableRemoveFromFavouritesButton;
  final bool enableCalendarButton;
  final bool enableShareButton;

  const SightCard(
    this.sight, {
    Key? key,
    this.showDetails = true,
    this.enableToFavouritesButton = true,
    this.enableRemoveFromFavouritesButton = false,
    this.enableCalendarButton = false,
    this.enableShareButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Column(
          children: [
            Expanded(
              child: _SightCardTop(
                sight,
                enableToFavouritesButton: enableToFavouritesButton,
                enableRemoveFromFavouritesButton:
                    enableRemoveFromFavouritesButton,
                enableCalendarButton: enableCalendarButton,
                enableShareButton: enableShareButton,
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
    );
  }
}

/// Виджет верхняя часть карточки достопримечательности.
///
/// Содержит картинку и тип места.
///
/// Имеет параметры:
/// * [sight] - модель достопримечательности;
/// * [enableToFavouritesButton] - признак отображения кнопки добавления в избранное;
/// * [enableRemoveFromFavouritesButton] - признак отображения кнопки удаления из избранного;
/// * [enableCalendarButton] - признак отображения картинки календаря (запланировано к посещению);
/// * [enableShareButton] - признак отображения кнопки "поделиться".
class _SightCardTop extends StatelessWidget {
  final bool enableToFavouritesButton;
  final bool enableRemoveFromFavouritesButton;
  final bool enableCalendarButton;
  final bool enableShareButton;

  final Sight sight;

  const _SightCardTop(
    this.sight, {
    Key? key,
    required this.enableToFavouritesButton,
    required this.enableRemoveFromFavouritesButton,
    required this.enableCalendarButton,
    required this.enableShareButton,
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
          Image.network(
            sight.url,
            fit: BoxFit.cover,
            loadingBuilder: LoadingIndicator.imageLoadingBuilder,
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
                  style: AppTypography.roboto14Regular
                      .copyWith(color: AppColors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  top: 19,
                ),
                // Действия с карточкой.
                child: _SightActions(
                  enableToFavouritesButton: enableToFavouritesButton,
                  enableRemoveFromFavouritesButton:
                      enableRemoveFromFavouritesButton,
                  enableCalendarButton: enableCalendarButton,
                  enableShareButton: enableShareButton,
                ),
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
/// Имеет параметры:
/// * [enableToFavouritesButton] - признак отображения кнопки добавления в избранное;
/// * [enableRemoveFromFavouritesButton] - признак отображения кнопки удаления из избранного;
/// * [enableCalendarButton] - признак отображения картинки календаря (запланировано к посещению);
/// * [enableShareButton] - признак отображения кнопки "поделиться".
class _SightActions extends StatelessWidget {
  final bool enableToFavouritesButton;
  final bool enableRemoveFromFavouritesButton;
  final bool enableCalendarButton;
  final bool enableShareButton;

  const _SightActions({
    Key? key,
    required this.enableToFavouritesButton,
    required this.enableRemoveFromFavouritesButton,
    required this.enableCalendarButton,
    required this.enableShareButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Картинка лайка.
        if (enableToFavouritesButton)
          Container(
            margin: const EdgeInsets.only(
              left: 23.0,
            ),
            width: 20,
            height: 18,
            color: AppColors.white,
          ),
        // Картинка календаря.
        if (enableCalendarButton)
          Container(
            margin: const EdgeInsets.only(
              left: 23.0,
            ),
            width: 20,
            height: 18,
            color: AppColors.waterloo,
          ),
        // Картинка "поделиться".
        if (enableShareButton)
          Container(
            margin: const EdgeInsets.only(
              left: 23.0,
            ),
            width: 20,
            height: 18,
            color: AppColors.martinique,
          ),
        // Картинка удаления из избранного.
        if (enableRemoveFromFavouritesButton)
          Container(
            margin: const EdgeInsets.only(
              left: 23.0,
            ),
            width: 20,
            height: 18,
            color: AppColors.fruitSalad,
          ),
      ],
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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: AppColors.wildSand,
      ),
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
                color: AppColors.oxfordBlue,
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
          color: AppColors.waterloo,
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
              color: sight.visited ? AppColors.waterloo : AppColors.fruitSalad,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            '${AppStrings.closedTo} ${sight.workTimeFrom}',
            style: AppTypography.roboto14Regular.copyWith(
              color: AppColors.waterloo,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
