import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_typography.dart';

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
    // Не используется
    background: _whiteColor,
    onPrimary: _oxfordBlueColor,
    onBackground: _whiteColor,
    // Не используется
    onError: _whiteColor,
    onSecondary: _whiteColor,
    // Не используется
    onSurface: _whiteColor,
    // Не используется
    error: _whiteColor,
    primary: AppColors.fruitSalad,
    // Не используется
    primaryContainer: _whiteColor,
    secondary: _waterlooColor,
    secondaryContainer: AppColors.wildSand,
    // Не используется
    surface: _whiteColor,
    // Не используется
    brightness: Brightness.light,
  ),
  // Настройки шрифтов
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
    // Не используется
    background: _whiteColor,
    onPrimary: _waterlooColor,
    onBackground: _whiteColor,
    // Не используется
    onError: _whiteColor,
    onSecondary: _whiteColor,
    // Не используется
    onSurface: _whiteColor,
    // Не используется
    error: _whiteColor,
    primary: AppColors.pastelGreen,
    // Не используется
    primaryContainer: _whiteColor,
    secondary: _waterlooColor,
    secondaryContainer: AppColors.shark,
    // Не используется
    surface: _whiteColor,
    // Не используется
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
  headline4: AppTypography.roboto32Regular.copyWith(
    fontWeight: fontWeight700,
  ),
  headline5: AppTypography.roboto24Regular.copyWith(
    fontWeight: fontWeight700,
  ),
  subtitle1: AppTypography.roboto18Regular.copyWith(
    fontWeight: fontWeight500,
  ),
  bodyText1: AppTypography.roboto16Regular,
  button: AppTypography.roboto16Regular.copyWith(
    fontWeight: fontWeight500,
  ),
  bodyText2: AppTypography.roboto14Regular,
  caption: AppTypography.roboto12Regular,
);

/// Настройки шрифтов для светлой темы.
final _lightTextTheme = _generalTextTheme.copyWith(
  headline4: _generalTextTheme.headline4?.copyWith(
    color: _martiniqueColor,
  ),
  headline5: _generalTextTheme.headline5?.copyWith(
    color: _oxfordBlueColor,
  ),
  subtitle1: _generalTextTheme.subtitle1?.copyWith(
    color: _martiniqueColor,
  ),
  bodyText1: _generalTextTheme.bodyText1?.copyWith(
    color: _martiniqueColor,
  ),
  button: _generalTextTheme.button?.copyWith(
    color: _oxfordBlueColor,
  ),
  bodyText2: _generalTextTheme.bodyText2?.copyWith(
    color: _oxfordBlueColor,
  ),
  caption: _generalTextTheme.caption?.copyWith(
    color: _oxfordBlueColor,
  ),
);

/// Настройки шрифтов для тёмной темы.
final _darkTextTheme = _generalTextTheme.copyWith(
  headline4: _generalTextTheme.headline4?.copyWith(
    color: _whiteColor,
  ),
  headline5: _generalTextTheme.headline5?.copyWith(
    color: _whiteColor,
  ),
  subtitle1: _generalTextTheme.subtitle1?.copyWith(
    color: _whiteColor,
  ),
  bodyText1: _generalTextTheme.bodyText1?.copyWith(
    color: _whiteColor,
  ),
  button: _generalTextTheme.button?.copyWith(
    color: _whiteColor,
  ),
  bodyText2: _generalTextTheme.bodyText2?.copyWith(
    color: _whiteColor,
  ),
  caption: _generalTextTheme.caption?.copyWith(
    color: _whiteColor,
  ),
);