import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/placeholders/info_placeholder.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/utils/string_extension.dart';

/// Отображает плейсхолдер ошибки.
class ErrorPlaceHolder extends InfoPlaceHolder {
  @override
  String get iconPath => AppAssets.error;

  @override
  String get infoText => AppStrings.error.capitalize();

  @override
  String get descriptionText => AppStrings.errorDescription;

  const ErrorPlaceHolder({
    Key? key,
    double iconSize = 64.0,
  }) : super(key: key, iconSize: iconSize);
}
