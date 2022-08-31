import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_typography.dart';

/// Настройки для светлой темы.
final lightTheme = ThemeData(
  tabBarTheme: _lightTabBarTheme,
  bottomNavigationBarTheme: _lightBottomNavigationBarTheme,
);

/// Настройки для тёмной темы.
final darkTheme = ThemeData();

final _lightTabBarTheme = TabBarTheme(
  labelStyle: AppTypography.roboto14Regular.copyWith(
    color: AppColors.white,
  ),
  unselectedLabelColor: AppColors.waterlooInactive,
  indicatorSize: TabBarIndicatorSize.tab,
);

final _darkTabBarTheme = TabBarTheme(
  labelStyle: AppTypography.roboto14Regular.copyWith(
    color: AppColors.white,
  ),
  unselectedLabelColor: AppColors.waterlooInactive,
  indicatorSize: TabBarIndicatorSize.tab,
);

const _lightBottomNavigationBarTheme = BottomNavigationBarThemeData(
  selectedItemColor: AppColors.oxfordBlue,
  unselectedItemColor: AppColors.oxfordBlue,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  elevation: 3,
  type: BottomNavigationBarType.fixed,
);

const _darkBottomNavigationBarTheme = BottomNavigationBarThemeData(
  selectedItemColor: AppColors.oxfordBlue,
  unselectedItemColor: AppColors.oxfordBlue,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  elevation: 3,
  type: BottomNavigationBarType.fixed,
);
