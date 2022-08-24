import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';

/// Кнопка "Построить маршрут".
/// Предоставляет возможность построить маршрут к достопримечательности.
class BuildRouteButton extends StatelessWidget {
  const BuildRouteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.fruitSalad,
        ),
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 22,
              color: AppColors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              AppStrings.buildRouteText,
              style: AppTypography.roboto14Regular.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
