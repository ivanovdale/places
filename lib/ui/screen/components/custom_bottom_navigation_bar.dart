import 'package:flutter/material.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';

/// Кастомный BottomNavigationBar.
class CustomBottomNavigationBar extends StatelessWidget {
  static const double _itemIconSize = 24.0;

  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.waterlooInactive, width: 3),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 3,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: AppColors.oxfordBlue,
        unselectedItemColor: AppColors.oxfordBlue,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.itemListIcon,
              height: _itemIconSize,
              width: _itemIconSize,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.itemMapIcon,
              height: _itemIconSize,
              width: _itemIconSize,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.itemHeartFullIcon,
              height: _itemIconSize,
              width: _itemIconSize,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.itemSettingsIcon,
              height: _itemIconSize,
              width: _itemIconSize,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
