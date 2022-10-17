import 'package:flutter/material.dart';
import 'package:places/UI/screens/settings_screen.dart';
import 'package:places/UI/screens/sight_list_screen.dart';
import 'package:places/UI/screens/visiting_sights_screen.dart';
import 'package:places/helpers/app_assets.dart';

/// Хранит текущую выбранную вкладку.
class BottomBarProvider extends ChangeNotifier {
  /// Иконки и страницы.
  final items = [
    {
      'icon': AppAssets.list,
      'activeIcon': AppAssets.listFilled,
      'screen': const SightListScreen(),
    },
    {
      'icon': AppAssets.map,
      'activeIcon': AppAssets.mapFilled,
      'screen': const SightListScreen(), // Пока экрана нет.
    },
    {
      'icon': AppAssets.heart,
      'activeIcon': AppAssets.heartFilled,
      'screen': const VisitingSightsScreen(),
    },
    {
      'icon': AppAssets.settings,
      'activeIcon': AppAssets.settingsFilled,
      'screen': const SettingsScreen(),
    },
  ];

  /// Индекс текущей вкладки.
  int selectedIndex = 0;

  /// Переключает вкладки боттом бара.
  void onItemTapped(
    int index,
    BuildContext context,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => items[index]['screen'] as Widget,
      ),
    );

    selectedIndex = index;

    notifyListeners();
  }
}
