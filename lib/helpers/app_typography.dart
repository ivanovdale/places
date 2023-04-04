import 'package:flutter/material.dart';

/// Общая настройка шрифтов.
const _generalRobotoConfiguration = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

/// Шрифты приложения.
class AppTypography {
  /// Headline4.
  static final roboto32Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 32.0,
  );

  /// Headline5.
  static final roboto24Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 24.0,
  );

  /// Subtitle1.
  static final roboto18Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 18.0,
  );

  /// BodyText1 / button.
  static final roboto16Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 16.0,
  );

  /// BodyText2.
  static final roboto14Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 14.0,
  );

  /// Caption.
  static final roboto12Regular = _generalRobotoConfiguration.copyWith(
    fontSize: 12.0,
  );
}
