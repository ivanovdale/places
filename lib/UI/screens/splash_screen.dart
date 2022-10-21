import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/onboarding_screen.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';

/// Сплэш-экран с лого приложения.
///
/// Параметр [isInitialized] - отвечает за то, готово ли приложение
/// к дальнейшей работе для перехода на следующий экран.
class SplashScreen extends StatefulWidget {
  final Future<bool> isInitialized;

  const SplashScreen({
    Key? key,
    required this.isInitialized,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Состояние сплэш-экрана. Переходит на экран онбординга через заданное количество времени после запуска.
class _SplashScreenState extends State<SplashScreen> {
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

  @override
  void initState() {
    super.initState();
    widget.isInitialized.then(
      (value) => _navigateToNext(),
    );
  }

  /// Переход на экран онбординга.
  void _navigateToNext() {
    if (kDebugMode) {
      print('Переход на следующий экран');
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (context) => const OnboardingScreen()),
    );
  }
}
