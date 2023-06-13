import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/placeholders/info_placeholder.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';

/// Отображает информацию о пустом списке планируемых к посещению мест.
class EmptyToVisitPlaceHolder extends InfoPlaceHolder {
  @override
  String get iconPath => AppAssets.addNewCard;

  @override
  String get infoText => AppStrings.empty;

  @override
  String get descriptionText => AppStrings.infoMarkLikedPlaces;

  const EmptyToVisitPlaceHolder({
    Key? key,
    double iconSize = 64.0,
  }) : super(key: key, iconSize: iconSize);
}
