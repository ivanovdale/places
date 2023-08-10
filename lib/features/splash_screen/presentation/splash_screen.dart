import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_colors.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/features/splash_screen/utils/animation_helper.dart';

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
    final (:controller, :animation) = AnimationHelper.getSettings(vsync: this);
    _animationController = controller;
    _rotationAnimation = animation;

    _navigateToNextScreen();
  }

  // Дожидаемся инициализации приложения для перехода на следующий экран.
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () => true,
    );

    if (context.mounted) {
      await Navigator.pushReplacementNamed(
        context,
        AppRouter.onboarding,
      );
    }
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
