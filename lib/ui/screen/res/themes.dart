import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_typography.dart';

/// Настройки для светлой темы.
final lightTheme = ThemeData(
  tabBarTheme: _lightTabBarTheme,
  bottomNavigationBarTheme: _lightBottomNavigationBarTheme,
  backgroundColor: AppColors.white,
  primaryColor: AppColors.oxfordBlue,
  primaryColorDark: AppColors.martinique,
  colorScheme: const ColorScheme(
    background: AppColors.white,
    onPrimary: AppColors.white,
    onBackground: AppColors.black,
    onError: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.black,
    error: AppColors.black,
    primary: AppColors.fruitSalad,
    primaryContainer: AppColors.blue,
    secondary: AppColors.waterloo,
    // TODO(daniiliv): Сделать для темной темы.
    secondaryContainer: AppColors.wildSand,
    surface: AppColors.white,
    brightness: Brightness.light,
  ),
);

/// Настройки для тёмной темы.
final darkTheme = ThemeData();

final _lightTabBarTheme = TabBarTheme(
  labelStyle: AppTypography.roboto14Regular.copyWith(
    color: AppColors.white,
  ),
  unselectedLabelColor: AppColors.waterloo.withOpacity(0.56),
  indicatorSize: TabBarIndicatorSize.tab,
);

final _darkTabBarTheme = TabBarTheme(
  labelStyle: AppTypography.roboto14Regular.copyWith(
    color: AppColors.white,
  ),
  unselectedLabelColor: AppColors.waterloo.withOpacity(0.56),
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
