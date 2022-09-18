import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/ui/screen/components/custom_elevated_button.dart';
import 'package:places/ui/screen/components/custom_text_button.dart';
import 'package:places/ui/screen/components/loading_indicator.dart';
import 'package:places/ui/screen/components/padded_divider.dart';

/// Виджет для отображения подробностей достопримечательности.
///
/// Отображает картинку, название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 360,
            child: _SightDetailsTop(sight),
          ),
          Expanded(
            flex: 400,
            child: _SightDetailsBottom(sight),
          ),
        ],
      ),
    );
  }
}

/// Виджет для отображения верхней части подробностей достопримечательности.
///
/// Отображает картинку места и имеет кнопку "Назад".
class _SightDetailsTop extends StatelessWidget {
  final Sight sight;

  const _SightDetailsTop(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // TODO(daniiliv): Здесь будет картинка места.
        Image.network(
          sight.url,
          fit: BoxFit.cover,
          loadingBuilder: LoadingIndicator.imageLoadingBuilder,
        ),
        const Positioned(
          left: 16,
          top: 36,
          child: _BackButton(),
        ),
      ],
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
class _SightDetailsBottom extends StatelessWidget {
  final Sight sight;

  const _SightDetailsBottom(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SightInfo(sight),
        const Padding(
          padding: EdgeInsets.only(
            top: 24.0,
            left: 16.0,
            right: 16.0,
          ),
          child: _BuildRouteButton(),
        ),
        const PaddedDivider(
          top: 24,
          left: 16,
          right: 16,
          bottom: 16,
          thickness: 0.8,
        ),
        const _SightActionsButtons(),
      ],
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
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 16.0,
            ),
            child: Text(
              sight.name,
              style: AppTypography.roboto24Regular
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 2.0,
                left: 16.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  sight.type.toString(),
                  style: AppTypography.roboto14Regular
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 2.0,
                left: 16.0,
              ),
              child: Text(
                '${AppStrings.closedTo} ${sight.workTimeFrom}',
                style: AppTypography.roboto14Regular.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Text(
            sight.details,
            style: AppTypography.roboto14Regular.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
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
    return CustomElevatedButton(
      AppStrings.buildRouteText,
      textStyle: AppTypography.roboto14Regular.copyWith(
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      height: 48,
      // Картинка кнопки - пока что это просто белый контейнер.
      buttonLabel: SvgPicture.asset(
        AppAssets.route,
        width: 24,
        height: 24,
        color: Theme.of(context).colorScheme.onSecondary,
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
    return CustomTextButton(
      AppStrings.toPlanText,
      textStyle: AppTypography.roboto14Regular.copyWith(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.56),
        fontWeight: FontWeight.w400,
      ),
      buttonLabel: SvgPicture.asset(
        AppAssets.calendar,
        width: 24,
        height: 24,
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.56),
      ),
    );
  }
}

/// Кнопка "Добавить в избранное" указанное место.
class _ToFavouritesButton extends StatelessWidget {
  const _ToFavouritesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).primaryColor;

    return CustomTextButton(
      AppStrings.toFavourites,
      textStyle: AppTypography.roboto14Regular.copyWith(
        color: buttonColor,
        fontWeight: FontWeight.w400,
      ),
      buttonLabel: SvgPicture.asset(
        AppAssets.heart,
        width: 24,
        height: 24,
        color: buttonColor,
      ),
    );
  }
}

/// Кнопка "Вернуться назад" в список.
class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: ElevatedButton(
        // TODO(daniiliv): Здесь будет вызов реальной функции.
        onPressed: () {
          if (kDebugMode) {
            print('"Back" button pressed.');
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
