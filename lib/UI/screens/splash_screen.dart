import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/API/api.dart';
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

    // TODO(daniiliv): В учебных целях обратимся к апи.
    final dio = Api().httpClient;
    dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
    dio.get<String>('/users');

    // Дожидаемся инициализации приложения для перехода на следующий экран.
    Future.delayed(
      const Duration(seconds: 2),
      () => true,
    ).then(
      (value) => _navigateToNext(),
    );
  }

  /// Переход на экран онбординга.
  void _navigateToNext() {
    Navigator.pushReplacementNamed(
      context,
      AppRouter.onboarding,
    );
  }
}
