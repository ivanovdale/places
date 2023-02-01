import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/custom_divider.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/UI/screens/components/loading_indicator.dart';
import 'package:places/UI/screens/components/placeholders/error_placeholder.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/providers/interactor_provider.dart';
import 'package:places/providers/place_details_provider.dart';
import 'package:provider/provider.dart';

/// Экран подробностей места.
///
/// Отображает картинку, название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [placeId] - идентификатор места.
class PlaceDetailsScreen extends StatelessWidget {
  final int placeId;

  const PlaceDetailsScreen(this.placeId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Place>(
      future: getPlaceDetails(placeId, context),
      builder: (context, snapshot) {
        return snapshot.hasData || snapshot.hasError
            ? DraggableScrollableSheet(
                initialChildSize: 0.9,
                maxChildSize: 0.9,
                minChildSize: 0.5,
                builder: (_, scrollController) => ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Scaffold(
                    bottomSheet: snapshot.hasData
                        ? ChangeNotifierProvider(
                            create: (context) => PlaceDetailsProvider(),
                            child: CustomScrollView(
                              controller: scrollController,
                              slivers: [
                                _SliverAppBarPlacePhotos(snapshot.data!),
                                _SliverPlaceDetails(snapshot.data!),
                              ],
                            ),
                          )
                        : const Center(
                            child: ErrorPlaceHolder(),
                          ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  /// Получает детальную информацию места.
  Future<Place> getPlaceDetails(int placeId, BuildContext context) {
    return context
        .read<PlaceInteractorProvider>()
        .placeInteractor
        .getPlaceDetails(placeId);
  }
}

/// Сливер фотографий места.
///
/// Отображает картинки места и имеет кнопку "Закрыть".
/// Сворачивается при скроллинге.
class _SliverAppBarPlacePhotos extends StatelessWidget {
  final Place place;

  const _SliverAppBarPlacePhotos(this.place);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 360,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Consumer<PlaceDetailsProvider>(
          builder: (context, viewModel, child) => Stack(
            alignment: Alignment.center,
            children: [
              _PhotoGallery(
                place: place,
                controller: viewModel.pageController,
                onPageChanged: viewModel.setActivePage,
              ),
              _PageIndicator(
                length: place.photoUrlList?.length ?? 0,
                controller: viewModel.pageController,
                activePage: viewModel.activePage,
              ),
              const _CloseButton(),
              const _SwipeDownButton(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Галерея фотографии места.
class _PhotoGallery extends StatelessWidget {
  /// Картинка по умолчанию.
  static const defaultImageUrl =
      'https://wallbox.ru/resize/1024x768/wallpapers/main2/201726/pole12.jpg';

  final ValueSetter<int>? onPageChanged;
  final PageController controller;
  final Place place;

  const _PhotoGallery({
    Key? key,
    this.onPageChanged,
    required this.controller,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: place.photoUrlList?.length,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: place.photoUrlList?[index] ?? defaultImageUrl,
          fit: BoxFit.cover,
          progressIndicatorBuilder: LoadingIndicator.progressIndicatorBuilder,
          errorWidget: (context, url, dynamic error) => const Icon(Icons.error),
        );
      },
    );
  }
}

/// Индикатор прокрутки галлереи.
class _PageIndicator extends StatelessWidget {
  final int length;
  final PageController controller;
  final int activePage;

  const _PageIndicator({
    Key? key,
    required this.length,
    required this.controller,
    required this.activePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return length > 1
        ? Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 12,
            child: Row(
              children: List<Widget>.generate(
                length,
                (index) => InkWell(
                  onTap: () => indicatorOnTap(index),
                  child: Container(
                    width: MediaQuery.of(context).size.width / length,
                    decoration: BoxDecoration(
                      color: activePage == index
                          ? Theme.of(context).primaryColorDark
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          )
        // Не отображать индикатор фотографий, если количество фото меньше 2.
        : const SizedBox.shrink();
  }

  /// Устанавливает текущую фотографию галлереи.
  void indicatorOnTap(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}

/// Виджет для отображения нижней части подробностей места.
///
/// Отображает название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [place] - модель места.
class _SliverPlaceDetails extends StatelessWidget {
  final Place place;

  const _SliverPlaceDetails(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PlaceInfo(place),
            const _BuildRouteButton(),
            const CustomDivider(
              padding: EdgeInsets.only(
                top: 24,
                left: 16,
                right: 16,
                bottom: 8,
              ),
              thickness: 0.8,
            ),
            const _PlaceActionsButtons(),
          ],
        ),
      ),
    );
  }
}

/// Виджет для отображения информации о места.
///
/// Отображает название, тип, режим работы, описание места.
///
/// Обязательный параметр конструктора: [place] - модель места.
class _PlaceInfo extends StatelessWidget {
  final Place place;

  const _PlaceInfo(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeBodyText2 = theme.textTheme.bodyMedium;
    final onPrimaryColor = colorScheme.onPrimary;
    final secondaryColor = colorScheme.secondary;
    final primaryColor = theme.primaryColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PlaceName(
          place.name,
          textStyle: theme.textTheme.headlineSmall!,
        ),
        _PlaceDetailsInfo(
          place.type.toString(),
          workTime: place.workTimeFrom ?? '',
          placeTypeTextStyle: themeBodyText2!.copyWith(
            color: onPrimaryColor,
          ),
          workTimeTextStyle: themeBodyText2.copyWith(
            color: secondaryColor,
          ),
        ),
        _PlaceDescription(
          place.details,
          textStyle: themeBodyText2.copyWith(
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}

/// Название места.
class _PlaceName extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const _PlaceName(
    this.text, {
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}

/// Информация о месте.
class _PlaceDetailsInfo extends StatelessWidget {
  final String text;
  final TextStyle placeTypeTextStyle;
  final TextStyle workTimeTextStyle;
  final String workTime;

  const _PlaceDetailsInfo(
    this.text, {
    Key? key,
    required this.placeTypeTextStyle,
    required this.workTime,
    required this.workTimeTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 2,
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: placeTypeTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Text(
              '${AppStrings.closedTo} $workTime',
              style: workTimeTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

/// Описание места.
class _PlaceDescription extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const _PlaceDescription(
    this.text, {
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
        right: 16.0,
      ),
      height: 90,
      child: SingleChildScrollView(
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}

/// Кнопка "Построить маршрут".
class _BuildRouteButton extends StatelessWidget {
  const _BuildRouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onSecondaryColor = colorScheme.onSecondary;

    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
        right: 16.0,
      ),
      child: CustomElevatedButton(
        AppStrings.buildRouteText,
        textStyle: theme.textTheme.bodyMedium?.copyWith(
          color: onSecondaryColor,
        ),
        backgroundColor: colorScheme.primary,
        height: 48,
        // Картинка кнопки - пока что это просто белый контейнер.
        buttonLabel: SvgPicture.asset(
          AppAssets.route,
          width: 24,
          height: 24,
          color: onSecondaryColor,
        ),
        // TODO(daniiliv): Здесь будет вызов реальной функции.
        onPressed: () {
          if (kDebugMode) {
            print('"${AppStrings.buildRouteText}" button pressed.');
          }
        },
      ),
    );
  }
}

/// Виджет для отображения кнопок для работы с местом.
///
/// Предоставляет возможность запланировать поход в место и добавить его в список избранного.
class _PlaceActionsButtons extends StatelessWidget {
  const _PlaceActionsButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _ToPlanButton(),
        ),
        Expanded(
          child: _ToFavouritesButton(),
        ),
      ],
    );
  }
}

/// Кнопка "Запланировать" поход в указанное место.
class _ToPlanButton extends StatelessWidget {
  const _ToPlanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary.withOpacity(0.56);

    return CustomTextButton(
      AppStrings.toPlanText,
      textStyle: theme.textTheme.bodyMedium?.copyWith(
        color: secondaryColor,
      ),
      buttonLabel: SvgPicture.asset(
        AppAssets.calendar,
        width: 24,
        height: 24,
        color: secondaryColor,
      ),
      // TODO(daniiliv): Здесь будет вызов реальной функции.
      onPressed: () {
        if (kDebugMode) {
          print('"${AppStrings.toPlanText}" button pressed.');
        }
      },
    );
  }
}

/// Кнопка "Добавить в избранное" указанное место.
class _ToFavouritesButton extends StatelessWidget {
  const _ToFavouritesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = theme.primaryColor;

    return CustomTextButton(
      AppStrings.toFavourites,
      textStyle: theme.textTheme.bodyMedium?.copyWith(
        color: buttonColor,
      ),
      buttonLabel: SvgPicture.asset(
        AppAssets.heart,
        width: 24,
        height: 24,
        color: buttonColor,
      ),
      // TODO(daniiliv): Здесь будет вызов реальной функции.
      onPressed: () {
        if (kDebugMode) {
          print('"${AppStrings.toFavourites}" button pressed.');
        }
      },
    );
  }
}

/// Кнопка "Закрыть" боттомшит.
class _CloseButton extends StatelessWidget {
  const _CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      top: 6,
      child: IconButton(
        icon: const Icon(
          Icons.cancel,
          size: 40,
        ),
        color: Theme.of(context).colorScheme.onBackground,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

/// Кнопка скрытия боттомшита.
class _SwipeDownButton extends StatelessWidget {
  const _SwipeDownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
