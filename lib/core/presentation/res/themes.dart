import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_colors.dart';
import 'package:places/core/helpers/app_typography.dart';

/// Основные цвета приложения.
const _oxfordBlueColor = AppColors.oxfordBlue;
const _whiteColor = AppColors.white;
const _martiniqueColor = AppColors.martinique;
const _waterlooColor = AppColors.waterloo;
const _charadeColor =  AppColors.charade;

/// Настройки для светлой темы.
final lightTheme = ThemeData(
  tabBarTheme: _lightTabBarTheme,
  bottomNavigationBarTheme: _lightBottomNavigationBarTheme,
  primaryColor: _oxfordBlueColor,
  primaryColorDark: _martiniqueColor,
  colorScheme: const ColorScheme(
    // Не используется.
    background: _whiteColor,
    onPrimary: _oxfordBlueColor,
    onBackground: _whiteColor,
    // Не используется.
    onError: _whiteColor,
    onSecondary: _whiteColor,
    // Не используется.
    onSurface: _whiteColor,
    // Не используется.
    error: _whiteColor,
    primary: AppColors.fruitSalad,
    // Не используется.
    primaryContainer: _whiteColor,
    secondary: _waterlooColor,
    secondaryContainer: AppColors.wildSand,
    // Не используется.
    surface: _whiteColor,
    // Не используется.
    brightness: Brightness.light,
  ),
  // Настройки шрифтов.
  textTheme: _lightTextTheme,
);

/// Настройки для тёмной темы.
final darkTheme = ThemeData(
  tabBarTheme: _darkTabBarTheme,
  bottomNavigationBarTheme: _darkBottomNavigationBarTheme,
  scaffoldBackgroundColor: _charadeColor,
  primaryColor: _whiteColor,
  primaryColorDark: _whiteColor,
  colorScheme: const ColorScheme(
    // Не используется.
    background: _whiteColor,
    onPrimary: _waterlooColor,
    onBackground: _whiteColor,
    // Не используется.
    onError: _whiteColor,
    onSecondary: _whiteColor,
    // Не используется.
    onSurface: _whiteColor,
    // Не используется.
    error: _whiteColor,
    primary: AppColors.pastelGreen,
    // Не используется.
    primaryContainer: _whiteColor,
    secondary: _waterlooColor,
    secondaryContainer: AppColors.shark,
    // Не используется.
    surface: _whiteColor,
    // Не используется.
    brightness: Brightness.light,
  ),
  textTheme: _darkTextTheme,
);

/// Общие настройки TabBar.
final _generalTabBarTheme = TabBarTheme(
  labelStyle: AppTypography.roboto14Regular,
  indicatorSize: TabBarIndicatorSize.tab,
);

/// Настройки TabBar для светлой темы.
final _lightTabBarTheme = _generalTabBarTheme.copyWith(
  unselectedLabelColor: _waterlooColor.withOpacity(0.56),
);

/// Настройки TabBar для тёмной темы.
final _darkTabBarTheme = _generalTabBarTheme.copyWith(
  labelColor: _oxfordBlueColor,
  unselectedLabelColor: _waterlooColor,
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
  backgroundColor: _charadeColor,
);

/// Константы для настройки шрифтов.
const fontWeight700 = FontWeight.w700;
const fontWeight500 = FontWeight.w500;

/// Общие настройки шрифтов.
final _generalTextTheme = TextTheme(
  headlineMedium: AppTypography.roboto32Regular.copyWith(
    fontWeight: fontWeight700,
  ),
  headlineSmall: AppTypography.roboto24Regular.copyWith(
    fontWeight: fontWeight700,
  ),
  titleMedium: AppTypography.roboto18Regular.copyWith(
    fontWeight: fontWeight500,
  ),
  bodyLarge: AppTypography.roboto16Regular,
  labelLarge: AppTypography.roboto16Regular.copyWith(
    fontWeight: fontWeight500,
  ),
  bodyMedium: AppTypography.roboto14Regular,
  bodySmall: AppTypography.roboto12Regular,
);

/// Настройки шрифтов для светлой темы.
final _lightTextTheme = _generalTextTheme.copyWith(
  headlineMedium: _generalTextTheme.headlineMedium?.copyWith(
    color: _martiniqueColor,
  ),
  headlineSmall: _generalTextTheme.headlineSmall?.copyWith(
    color: _oxfordBlueColor,
  ),
  titleMedium: _generalTextTheme.titleMedium?.copyWith(
    color: _martiniqueColor,
  ),
  bodyLarge: _generalTextTheme.bodyLarge?.copyWith(
    color: _martiniqueColor,
  ),
  labelLarge: _generalTextTheme.labelLarge?.copyWith(
    color: _oxfordBlueColor,
  ),
  bodyMedium: _generalTextTheme.bodyMedium?.copyWith(
    color: _oxfordBlueColor,
  ),
  bodySmall: _generalTextTheme.bodySmall?.copyWith(
    color: _oxfordBlueColor,
  ),
);

/// Настройки шрифтов для тёмной темы.
final _darkTextTheme = _generalTextTheme.copyWith(
  headlineMedium: _generalTextTheme.headlineMedium?.copyWith(
    color: _whiteColor,
  ),
  headlineSmall: _generalTextTheme.headlineSmall?.copyWith(
    color: _whiteColor,
  ),
  titleMedium: _generalTextTheme.titleMedium?.copyWith(
    color: _whiteColor,
  ),
  bodyLarge: _generalTextTheme.bodyLarge?.copyWith(
    color: _whiteColor,
  ),
  labelLarge: _generalTextTheme.labelLarge?.copyWith(
    color: _whiteColor,
  ),
  bodyMedium: _generalTextTheme.bodyMedium?.copyWith(
    color: _whiteColor,
  ),
  bodySmall: _generalTextTheme.bodySmall?.copyWith(
    color: _whiteColor,
  ),
);