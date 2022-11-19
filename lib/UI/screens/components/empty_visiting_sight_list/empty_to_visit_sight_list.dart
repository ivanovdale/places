import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/empty_visiting_sight_list/base_empty_visiting_sight_list.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';

/// Отображает информацию о пустом списке планируемых к посещению мест.
class EmptyToVisitSightList extends BaseEmptyVisitingList {
  @override
  String get emptyIconPath => AppAssets.addNewCard;

  @override
  String get emptyInfo => AppStrings.infoMarkLikedPlaces;

  const EmptyToVisitSightList({
    Key? key,
  }) : super(key: key);
}
