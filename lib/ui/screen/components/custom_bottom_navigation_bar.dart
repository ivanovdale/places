import 'package:flutter/material.dart';
import 'package:places/helpers/app_assets.dart';

/// Кастомный BottomNavigationBar.
class CustomBottomNavigationBar extends StatelessWidget {
  static const double _itemIconSize = 24.0;

  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.56),
            width: 3,
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.itemListIcon,
              height: _itemIconSize,
              width: _itemIconSize,
              color: Theme.of(context).primaryColorDark,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.itemMapIcon,
              height: _itemIconSize,
              width: _itemIconSize,
              color: Theme.of(context).primaryColorDark,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.itemHeartFullIcon,
              height: _itemIconSize,
              width: _itemIconSize,
              color: Theme.of(context).primaryColorDark,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.itemSettingsIcon,
              height: _itemIconSize,
              width: _itemIconSize,
              color: Theme.of(context).primaryColorDark,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
