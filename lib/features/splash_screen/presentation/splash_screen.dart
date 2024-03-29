import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/domain/interactor/first_enter_interactor.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_colors.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/features/splash_screen/utils/logo_animation_helper.dart';

/// Сплэш-экран с лого приложения.
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Состояние сплэш-экрана. Переходит на экран онбординга через заданное количество времени после запуска.
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    final (:controller, :animation) =
        LogoAnimationHelper.getSettings(vsync: this);
    _animationController = controller;
    _rotationAnimation = animation;

    _navigateToNextScreen();
  }

  // Дожидаемся инициализации приложения для перехода на следующий экран.
  Future<void> _navigateToNextScreen() async {
    final navigator = Navigator.of(context);
    final firstEnterInteractor = context.read<FirstEnterInteractor>();
    final isFirstEnter = await firstEnterInteractor.isFirstEnter;
    if (isFirstEnter) firstEnterInteractor.saveFirstEnter();

    await Future.delayed(
      const Duration(milliseconds: 3200),
    );

    await navigator.pushReplacementNamed(
      isFirstEnter ? AppRouter.onBoarding : AppRouter.placeList,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.brightSun,
            AppColors.fruitSalad,
          ],
        ),
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value * 2 * -math.pi,
            child: SvgPicture.asset(
              AppAssets.appLogo,
              fit: BoxFit.none,
            ),
          );
        },
      ),
    );
  }
}
