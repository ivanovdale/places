import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/empty_visiting_sight_list/base_empty_visiting_sight_list.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';

/// Отображает информацию о пустом списке посещенных мест.
class EmptyVisitedSightList extends BaseEmptyVisitingList {
  @override
  String get emptyIconPath => AppAssets.emptyRoute;

  @override
  String get emptyInfo => AppStrings.infoFinishRoute;

  const EmptyVisitedSightList({
    Key? key,
  }) : super(key: key);
}
