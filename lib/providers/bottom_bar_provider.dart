import 'package:flutter/material.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_router.dart';

/// Хранит текущую выбранную вкладку.
class BottomBarProvider extends ChangeNotifier {
  /// Иконки и страницы.
  final List<Map<String, String>> items = [
    {
      'icon': AppAssets.list,
      'activeIcon': AppAssets.listFilled,
      'routeName': AppRouter.placeList,
    },
    {
      'icon': AppAssets.map,
      'activeIcon': AppAssets.mapFilled,
      'routeName': AppRouter.placeList, // Пока экрана нет.
    },
    {
      'icon': AppAssets.heart,
      'activeIcon': AppAssets.heartFilled,
      'routeName': AppRouter.visitingPlaces,
    },
    {
      'icon': AppAssets.settings,
      'activeIcon': AppAssets.settingsFilled,
      'routeName': AppRouter.settings,
    },
  ];

  /// Индекс текущей вкладки.
  int selectedIndex = 0;

  /// Переключает вкладки боттом бара.
  void onItemTapped(
    int index,
    BuildContext context,
  ) {
    Navigator.pushReplacementNamed(
      context,
      items[index]['routeName'] as String,
    );
    selectedIndex = index;
    notifyListeners();
  }
}
