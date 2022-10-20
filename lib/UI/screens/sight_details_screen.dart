import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/loading_indicator.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/providers/sight_details_provider.dart';
import 'package:places/ui/screens/components/custom_divider.dart';
import 'package:places/ui/screens/components/custom_elevated_button.dart';
import 'package:places/ui/screens/components/custom_text_button.dart';
import 'package:provider/provider.dart';

/// Виджет для отображения подробностей достопримечательности.
///
/// Отображает картинку, название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class SightDetailsScreen extends StatelessWidget {
  final Sight sight;

  const SightDetailsScreen(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (context) => SightDetailsProvider(),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _SliverSightPhotos(sight),
              _SliverSightDetails(sight),
            ],
          ),
        ),
      ),
    );
  }
}

/// Сливер фотографий достопримечательности.
///
/// Сворачивается при скроллинге.
class _SliverSightPhotos extends StatelessWidget {
  final Sight sight;

  const _SliverSightPhotos(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SightPhotosDelegate(sight),
    );
  }
}

/// Делегат для отображения фотографий достопримечательности.
///
/// Отображает картинки места и имеет кнопку "Назад".
class _SightPhotosDelegate extends SliverPersistentHeaderDelegate {
  final Sight sight;

  @override
  double get maxExtent => 360;

  @override
  double get minExtent => 0;

  const _SightPhotosDelegate(this.sight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Consumer<SightDetailsProvider>(
      builder: (context, viewModel, child) => Stack(
        fit: StackFit.expand,
        children: [
          _PhotoGallery(
            sight: sight,
            controller: viewModel.pageController,
            onPageChanged: viewModel.setActivePage,
          ),
          _PageIndicator(
            length: sight.photoUrlList?.length ?? 0,
            controller: viewModel.pageController,
            activePage: viewModel.activePage,
          ),
          const _BackButton(),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

/// Галерея фотографии достопримечательности.
class _PhotoGallery extends StatelessWidget {
  /// Картинка по умолчанию.
  static const defaultImageUrl =
      'https://wallbox.ru/resize/1024x768/wallpapers/main2/201726/pole12.jpg';

  final Function(int)? onPageChanged;
  final PageController controller;
  final Sight sight;

  const _PhotoGallery({
    Key? key,
    this.onPageChanged,
    required this.controller,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: sight.photoUrlList?.length,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: sight.photoUrlList?[index] ?? defaultImageUrl,
          fit: BoxFit.cover,
          progressIndicatorBuilder: LoadingIndicator.progressIndicatorBuilder,
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

/// Виджет для отображения нижней части подробностей достопримечательности.
///
/// Отображает название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class _SliverSightDetails extends StatelessWidget {
  final Sight sight;

  const _SliverSightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        children: [
          _SightInfo(sight),
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
          const _SightActionsButtons(),
        ],
      ),
    );
  }
}

/// Виджет для отображения информации о достопримечательности.
///
/// Отображает название, тип, режим работы, описание места.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class _SightInfo extends StatelessWidget {
  final Sight sight;

  const _SightInfo(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeBodyText2 = theme.textTheme.bodyText2;
    final onPrimaryColor = colorScheme.onPrimary;
    final secondaryColor = colorScheme.secondary;
    final primaryColor = theme.primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SightName(
          sight.name,
          textStyle: theme.textTheme.headline5!,
        ),
        _SightDetailsInfo(
          sight.type.toString(),
          workTime: sight.workTimeFrom ?? '',
          sightTypeTextStyle: themeBodyText2!.copyWith(
            color: onPrimaryColor,
          ),
          workTimeTextStyle: themeBodyText2.copyWith(
            color: secondaryColor,
          ),
        ),
        _SightDescription(
          sight.details,
          textStyle: themeBodyText2.copyWith(
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}

/// Название достопримечательности.
class _SightName extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const _SightName(
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

/// Информация о достопримечательности.
class _SightDetailsInfo extends StatelessWidget {
  final String text;
  final TextStyle sightTypeTextStyle;
  final TextStyle workTimeTextStyle;
  final String workTime;

  const _SightDetailsInfo(
    this.text, {
    Key? key,
    required this.sightTypeTextStyle,
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
              style: sightTypeTextStyle,
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

/// Описание достопримечательности.
class _SightDescription extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const _SightDescription(
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
        textStyle: theme.textTheme.bodyText2?.copyWith(
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

/// Виджет для отображения кнопок для работы с достопримечательностью.
///
/// Предоставляет возможность запланировать поход в место и добавить его в список избранного.
class _SightActionsButtons extends StatelessWidget {
  const _SightActionsButtons({Key? key}) : super(key: key);

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
      textStyle: theme.textTheme.bodyText2?.copyWith(
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
      textStyle: theme.textTheme.bodyText2?.copyWith(
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

/// Кнопка "Вернуться назад" в список.
class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      left: 16,
      top: 36,
      child: SizedBox(
        height: 32,
        width: 32,
        child: ElevatedButton(
          // TODO(daniiliv): Здесь будет вызов реальной функции.
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: theme.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            enableFeedback: true,
            padding: EdgeInsets.zero,
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 15.0,
            color: theme.primaryColorDark,
          ),
        ),
      ),
    );
  }
}
