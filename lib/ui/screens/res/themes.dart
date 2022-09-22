import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_typography.dart';

/// Настройки для светлой темы.
final lightTheme = ThemeData(
  tabBarTheme: _lightTabBarTheme,
  bottomNavigationBarTheme: _lightBottomNavigationBarTheme,
  primaryColor: AppColors.oxfordBlue,
  primaryColorDark: AppColors.martinique,
  colorScheme: const ColorScheme(
    // Не используется
    background: AppColors.white,
    onPrimary: AppColors.oxfordBlue,
    onBackground: AppColors.white,
    // Не используется
    onError: AppColors.white,
    onSecondary: AppColors.white,
    // Не используется
    onSurface: AppColors.white,
    // Не используется
    error: AppColors.white,
    primary: AppColors.fruitSalad,
    // Не используется
    primaryContainer: AppColors.white,
    secondary: AppColors.waterloo,
    secondaryContainer: AppColors.wildSand,
    // Не используется
    surface: AppColors.white,
    // Не используется
    brightness: Brightness.light,
  ),
);

/// Настройки для тёмной темы.
final darkTheme = ThemeData(
  tabBarTheme: _darkTabBarTheme,
  bottomNavigationBarTheme: _darkBottomNavigationBarTheme,
  scaffoldBackgroundColor: AppColors.charade,
  primaryColor: AppColors.white,
  primaryColorDark: AppColors.white,
  colorScheme: const ColorScheme(
    // Не используется
    background: AppColors.white,
    onPrimary: AppColors.waterloo,
    onBackground: AppColors.white,
    // Не используется
    onError: AppColors.white,
    onSecondary: AppColors.white,
    // Не используется
    onSurface: AppColors.white,
    // Не используется
    error: AppColors.white,
    primary: AppColors.pastelGreen,
    // Не используется
    primaryContainer: AppColors.white,
    secondary: AppColors.waterloo,
    secondaryContainer: AppColors.shark,
    // Не используется
    surface: AppColors.white,
    // Не используется
    brightness: Brightness.light,
  ),
);

/// Общие настройки TabBar.
const _generalTabBarTheme = TabBarTheme(
  labelStyle: AppTypography.roboto14Regular,
  indicatorSize: TabBarIndicatorSize.tab,
);

/// Настройки TabBar для светлой темы.
final _lightTabBarTheme = _generalTabBarTheme.copyWith(
  unselectedLabelColor: AppColors.waterloo.withOpacity(0.56),
);

/// Настройки TabBar для тёмной темы.
final _darkTabBarTheme = _generalTabBarTheme.copyWith(
  labelColor: AppColors.oxfordBlue,
  unselectedLabelColor: AppColors.waterloo,
);

/// Общие настройки BottomNavigationBar.
const _generalBottomNavigationBarTheme = BottomNavigationBarThemeData(
  showSelectedLabels: false,
  showUnselectedLabels: false,
  elevation: 3,
  type: BottomNavigationBarType.fixed,
);

/// Настройки BottomNavigationBar для светлой темы.
const _lightBottomNavigationBarTheme = _generalBottomNavigationBarTheme;

/// Настройки BottomNavigationBar для тёмной темы.
final _darkBottomNavigationBarTheme = _generalBottomNavigationBarTheme.copyWith(
  backgroundColor: AppColors.charade,
);
