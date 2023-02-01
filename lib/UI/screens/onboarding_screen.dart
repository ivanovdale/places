import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_router.dart';
import 'package:places/helpers/app_strings.dart';

/// Список с данными для страниц онбординга.
final List<Map<String, Object>> items = [
  {
    'title': AppStrings.welcomeInfo,
    'description': AppStrings.findAndLikePlacesInfo,
    'icon': AppAssets.welcome,
  },
  {
    'title': AppStrings.getRouteAndGoInfo,
    'description': AppStrings.reachPointFastAndComfortableInfo,
    'icon': AppAssets.backpack,
  },
  {
    'title': AppStrings.addPlacesYouFoundInfo,
    'description': AppStrings.shareAndHelpUsInfo,
    'icon': AppAssets.tap,
  },
];

/// Экран онбординга.
/// Отображает подсказку - как пользоваться приложением.
///
/// Экран отображается при первом запуске приложения или через экран настроек.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

/// Состояние экрана онбординга.
class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _SkipButton(
            activePage: _activePage,
            onPressed: () => goToPlaceListScreen(context),
          ),
          _OnboardingPageView(
            controller: _pageController,
            onPageChanged: setActivePage,
          ),
          _PageIndicator(
            length: items.length,
            controller: _pageController,
            activePage: _activePage,
          ),
          _StartButton(
            activePage: _activePage,
            onPressed: () => goToPlaceListScreen(context),
          ),
        ],
      ),
    );
  }

  /// Устанавливает активную страницу.
  void setActivePage(int page) {
    setState(() {
      _activePage = page;
    });
  }

  /// Выполняет переход на главную страницу, если стек экранов пуст.
  void goToPlaceListScreen(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRouter.placeList,
      );
    }
  }
}

/// Прокручивающийся список страниц.
class _OnboardingPageView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int>? onPageChanged;

  const _OnboardingPageView({
    Key? key,
    required this.controller,
    this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: MediaQuery.of(context).orientation == Orientation.portrait ? 5 : 10,
      child: PageView.builder(
        controller: controller,
        onPageChanged: onPageChanged,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _PageItem(
            index: index,
          );
        },
      ),
    );
  }
}

/// Страница онбординга.
///
/// Содержит приветственную картинку и краткую информацию о возможностях приложения.
class _PageItem extends StatelessWidget {
  final int index;

  const _PageItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColorDark = theme.primaryColorDark;
    final pageItemTitleStyle = theme.textTheme.headlineSmall!.copyWith(
      color: primaryColorDark,
    );
    final pageItemDescriptionStyle = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.secondary,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PageItemIcon(
          assetName: items[index]['icon'] as String,
          color: primaryColorDark,
        ),
        _PageItemTitle(
          data: items[index]['title'] as String,
          style: pageItemTitleStyle,
        ),
        _PageItemDescription(
          data: items[index]['description'] as String,
          style: pageItemDescriptionStyle,
        ),
      ],
    );
  }
}

/// Приветственная картинка страницы онбординга.
class _PageItemIcon extends StatelessWidget {
  final String assetName;
  final Color color;

  const _PageItemIcon({
    Key? key,
    required this.assetName,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 42.0),
      child: SvgPicture.asset(
        assetName,
        width: 100,
        color: color,
      ),
    );
  }
}

/// Заголовок страницы онбординга.
class _PageItemTitle extends StatelessWidget {
  final String data;
  final TextStyle style;

  const _PageItemTitle({
    Key? key,
    required this.data,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        data,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Описание страницы онбординга.
class _PageItemDescription extends StatelessWidget {
  final String data;
  final TextStyle style;

  const _PageItemDescription({
    Key? key,
    required this.data,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        data,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Индикатор прокрутки страниц онбординга.
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
    final theme = Theme.of(context);

    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          length,
          (index) => InkWell(
            onTap: () => indicatorOnTap(index),
            child: Container(
              height: 8,
              width: index == activePage ? 24 : 8,
              decoration: BoxDecoration(
                color: index == activePage
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondary.withOpacity(0.56),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
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

/// Кнопка для пропуска онбординга.
class _SkipButton extends StatelessWidget {
  final int activePage;
  final VoidCallback onPressed;

  const _SkipButton({
    Key? key,
    required this.onPressed,
    required this.activePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      // Кнопка не показывается для последней страницы.
      child: activePage == items.length - 1
          ? const SizedBox.shrink()
          : Container(
              padding: const EdgeInsets.only(
                right: 16,
              ),
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                AppStrings.skip,
                textStyle: theme.textTheme.labelLarge!.copyWith(
                  color: theme.colorScheme.primary,
                ),
                onPressed: onPressed,
              ),
            ),
    );
  }
}

/// Кнопка перехода на главный экран.
class _StartButton extends StatelessWidget {
  final int activePage;
  final VoidCallback onPressed;

  const _StartButton({
    Key? key,
    required this.activePage,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Кнопка показывается для последнего элемента списка.
    return activePage == items.length - 1
        ? Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: CustomElevatedButton(
              AppStrings.start,
              backgroundColor: colorScheme.primary,
              height: 48,
              textStyle: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onBackground,
              ),
              onPressed: onPressed,
            ),
          )
        : const SizedBox(
            height: 64,
          );
  }
}
