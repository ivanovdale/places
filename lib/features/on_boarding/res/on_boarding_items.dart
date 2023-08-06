import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/features/on_boarding/domain/on_boarding_data.dart';

/// Список с данными для страниц онбординга.
const List<OnBoardingData> items = [
  OnBoardingData(
    title: AppStrings.welcomeInfo,
    description: AppStrings.findAndLikePlacesInfo,
    icon: AppAssets.welcome,
  ),
  OnBoardingData(
    title: AppStrings.getRouteAndGoInfo,
    description: AppStrings.reachPointFastAndComfortableInfo,
    icon: AppAssets.backpack,
  ),
  OnBoardingData(
    title: AppStrings.addPlacesYouFoundInfo,
    description: AppStrings.shareAndHelpUsInfo,
    icon: AppAssets.tap,
  ),
];
