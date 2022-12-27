import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/empty_visiting_place_list/base_empty_visiting_place_list.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';

/// Отображает информацию о пустом списке планируемых к посещению мест.
class EmptyToVisitPlaceList extends BaseEmptyVisitingList {
  @override
  String get emptyIconPath => AppAssets.addNewCard;

  @override
  String get emptyInfo => AppStrings.infoMarkLikedPlaces;

  const EmptyToVisitPlaceList({
    Key? key,
  }) : super(key: key);
}
