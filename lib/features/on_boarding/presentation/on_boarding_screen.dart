import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
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
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final OnBoardingCubit _cubit = OnBoardingCubit();

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
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _cubit,
        child: Column(
          children: [
            BlocBuilder<OnBoardingCubit, OnBoardingState>(
              bloc: _cubit,
              builder: (context, state) {
                return SkipButton(
                  activePage: state.activePage,
                  onPressed: () => _goToPlaceListScreen(context),
                );
              },
            ),
            OnBoardingPageView(
              pageController: _pageController,
              onPageChanged: _cubit.setActivePage,
            ),
            BlocBuilder<OnBoardingCubit, OnBoardingState>(
              builder: (context, state) {
                return OnBoardingPageIndicator(
                  length: items.length,
                  controller: _pageController,
                  activePage: state.activePage,
                );
              },
            ),
            BlocBuilder<OnBoardingCubit, OnBoardingState>(
              builder: (context, state) {
                return StartButton(
                  activePage: state.activePage,
                  onPressed: () => _goToPlaceListScreen(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
