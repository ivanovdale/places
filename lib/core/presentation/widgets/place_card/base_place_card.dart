import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:places/UI/screens/place_details_screen.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/utils/image_error_helper.dart';
import 'package:places/core/utils/visiting_date_formatter.dart';

/// Абстрактный класс [BasePlaceCard]. Отображает краткую информацию о месте.
///
/// Имеет поля, которые необходимо переопределить в потомках:
/// * [actions] - кнопки для работы с карточкой.
/// * [showDetails] - признак отображения детальной информации (краткого описания) места.
///
/// Параметры:
/// * [place] - модель места.
abstract class BasePlaceCard extends StatelessWidget {
  final Place place;
  abstract final bool showDetails;
  abstract final Widget actions;

  const BasePlaceCard(
    this.place, {
    Key? key,
  }) : super(key: key);

  /// Показывает боттомшит детализации места.
  void _showPlaceDetailsBottomSheet(BuildContext context, Place place) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => PlaceDetailsScreen(place.id ?? 0),
    );
  }

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
            onTap: () => _showPlaceDetailsBottomSheet(context, place),
            child: Column(
              children: [
                Expanded(
                  child: _PlaceCardTop(
                    place,
                    actions,
                  ),
                ),
                Expanded(
                  child: _PlaceCardBottom(
                    place,
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

/// Виджет верхняя часть карточки места.
///
/// Содержит картинку и тип места.
///
/// Имеет параметры:
/// * [place] - модель места;
/// * [actions] - кнопки для работы с карточкой.
class _PlaceCardTop extends StatelessWidget {
  final Place place;
  final Widget actions;

  const _PlaceCardTop(
    this.place,
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

    // Используем первую картинку списка картинок места, если место имеет фотографии.
    // Если фотографий нет - используем дефолтную картинку.
    final imageUrl = place.photoUrlList?.isNotEmpty ?? false
        ? place.photoUrlList![0]
        : defaultImageUrl;

    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) {
            return Ink.image(image: imageProvider, fit: BoxFit.cover);
          },
          errorWidget: ImageErrorHelper.errorIcon,
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
                place.type.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
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
              child: actions,
            ),
          ],
        ),
      ],
    );
  }
}

/// Виджет нижняя часть карточки места.
///
/// Содержит краткую информацию о месте (Название места, краткое описание).
///
/// Имеет параметры:
/// * [place] - модель места;
/// * [showDetails] - отображать детали места (если стоит false, то будет отображена информация о будущем/произошедшем посещении).
class _PlaceCardBottom extends StatelessWidget {
  final Place place;
  final bool showDetails;

  const _PlaceCardBottom(
    this.place, {
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
                place.name,
                style: theme.textTheme.labelLarge,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            // Показывать информацию о месте.
            if (showDetails)
              Expanded(
                child: _PlaceDetailsInfo(place),
              )
            else
              Expanded(
                child: _PlaceVisitingInfo(place),
              ),
          ],
        ),
      ),
    );
  }
}

/// Отображает описание места.
///
/// Имеет параметры:
/// * [place] - модель места.
class _PlaceDetailsInfo extends StatelessWidget {
  final Place place;

  const _PlaceDetailsInfo(this.place, {Key? key}) : super(key: key);

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
        place.details,
        maxLines: 2,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: secondaryColor,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

/// Отображает информацию о предстоящем/завершенном посещении. Также отображает режим работы места.
///
/// Имеет параметры:
/// * [place] - модель места.
class _PlaceVisitingInfo extends StatelessWidget {
  final Place place;

  const _PlaceVisitingInfo(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final secondaryColor = theme.colorScheme.secondary;
    final themeBodyText2 = theme.textTheme.bodyMedium;

    final visitingText =
        place.visited ? AppStrings.placeVisited : AppStrings.planToVisit;
    final visitDateFormatted =
        VisitingDateFormatter.getFormattedString(visitingText, place.visitDate);

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
                  place.visited ? colorScheme.secondary : colorScheme.primary,
            ),
          ),
          const Spacer(),
          Text(
            '${AppStrings.closedTo} ${place.workTimeFrom}',
            style: themeBodyText2?.copyWith(
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
