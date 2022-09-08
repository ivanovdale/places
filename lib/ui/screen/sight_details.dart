import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/ui/screen/components/default_button.dart';
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
        // Здесь будет картинка места.
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
        Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            left: 16.0,
            right: 16.0,
          ),
          child: DefaultButton(
            text: AppStrings.buildRouteText,
            textStyle: AppTypography.roboto14Regular.copyWith(
              color: Theme.of(context).backgroundColor,
            ),
            color: Theme.of(context).colorScheme.primary,
            height: 48,
            // Картинка кнопки - пока что это просто белый контейнер.
            buttonLabel: Container(
              width: 20,
              height: 22,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
        const PaddedDivider(
          top: 24,
          left: 16,
          right: 16,
          bottom: 19,
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
                      .copyWith(color: Theme.of(context).primaryColor),
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
          child: ToPlanButton(),
        ),
        Expanded(
          child: _ToFavouritesButton(),
        ),
      ],
    );
  }
}

/// Кнопка "Запланировать" поход в указанное место.
class ToPlanButton extends StatelessWidget {
  const ToPlanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 22,
          height: 19,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.56),
        ),
        const SizedBox(
          width: 9,
        ),
        Text(
          AppStrings.planText,
          style: AppTypography.roboto14Regular.copyWith(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.56),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

/// Кнопка "Добавить в избранное" указанное место.
class _ToFavouritesButton extends StatelessWidget {
  const _ToFavouritesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 18,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 9,
        ),
        Text(
          AppStrings.toFavourites,
          style: AppTypography.roboto14Regular.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

/// Кнопка "Вернуться назад" в список.
class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).backgroundColor,
      ),
      width: 32,
      height: 32,
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 15.0,
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
