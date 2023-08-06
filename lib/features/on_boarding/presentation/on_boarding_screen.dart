import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/features/on_boarding/presentation/widgets/on_boarding_page_indicator.dart';
import 'package:places/features/on_boarding/presentation/widgets/on_boarding_page_view/on_boarding_page_view.dart';
import 'package:places/features/on_boarding/presentation/widgets/skip_button.dart';
import 'package:places/features/on_boarding/presentation/widgets/start_button.dart';
import 'package:places/features/on_boarding/res/on_boarding_items.dart';

/// Экран онбординга.
/// Отображает подсказку - как пользоваться приложением.
///
/// Экран отображается при первом запуске приложения или через экран настроек.
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _activePage = 0;

  /// Устанавливает активную страницу.
  void _setActivePage(int page) {
    setState(() {
      _activePage = page;
    });
  }

  /// Выполняет переход на главную страницу, если стек экранов пуст.
  void _goToPlaceListScreen(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRouter.placeList,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SkipButton(
            activePage: _activePage,
            onPressed: () => _goToPlaceListScreen(context),
          ),
          OnBoardingPageView(
            controller: _pageController,
            onPageChanged: _setActivePage,
          ),
          OnBoardingPageIndicator(
            length: items.length,
            controller: _pageController,
            activePage: _activePage,
          ),
          StartButton(
            activePage: _activePage,
            onPressed: () => _goToPlaceListScreen(context),
          ),
        ],
      ),
    );
  }
}
