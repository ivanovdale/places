import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/domain/bottom_navigation_bar_data.dart';

List<BottomNavigationBarData> bottomNavigationBarItems = const [
  BottomNavigationBarData(
    icon: AppAssets.list,
    activeIcon: AppAssets.listFilled,
    routeName: AppRouter.placeList,
  ),
  BottomNavigationBarData(
    icon: AppAssets.map,
    activeIcon: AppAssets.mapFilled,
    routeName: AppRouter.map, 
  ),
  BottomNavigationBarData(
    icon: AppAssets.heart,
    activeIcon: AppAssets.heartFilled,
    routeName: AppRouter.favouritePlaces,
  ),
  BottomNavigationBarData(
    icon: AppAssets.settings,
    activeIcon: AppAssets.settingsFilled,
    routeName: AppRouter.settings,
  ),
];
