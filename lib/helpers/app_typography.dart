import 'package:flutter/material.dart';

/// Общая настройка шрифтов.
const _generalRobotoConfiguration = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

/// Шрифты приложения.
class AppTypography {
  /// headline4
  static final roboto32Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 32.0,
  );

  /// headline5
  static final roboto24Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 24.0,
  );

  /// subtitle1
  static final roboto18Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 18.0,
  );

  /// bodyText1 / button
  static final roboto16Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 16.0,
  );

  /// bodyText2
  static final roboto14Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 14.0,
  );

  /// caption
  static final roboto12Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 12.0,
  );
}
