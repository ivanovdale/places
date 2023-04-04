import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_router.dart';

/// Сплэш-экран с лого приложения.
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Состояние сплэш-экрана. Переходит на экран онбординга через заданное количество времени после запуска.
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  // Дожидаемся инициализации приложения для перехода на следующий экран.
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 2),
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
      child: SvgPicture.asset(
        AppAssets.appLogo,
        fit: BoxFit.none,
      ),
    );
  }
}
