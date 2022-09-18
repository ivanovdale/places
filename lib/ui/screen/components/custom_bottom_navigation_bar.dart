import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/helpers/app_assets.dart';

/// Кастомный BottomNavigationBar.
class CustomBottomNavigationBar extends StatelessWidget {
  static const double _itemIconSize = 24.0;
  static const _itemAssets = [
    AppAssets.itemListIcon,
    AppAssets.itemMapIcon,
    AppAssets.itemHeartFullIcon,
    AppAssets.itemSettingsIcon,
  ];

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
        items: _itemAssets.map((itemAsset) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              itemAsset,
              height: _itemIconSize,
              width: _itemIconSize,
              color: Theme.of(context).primaryColorDark,
            ),
            label: '',
          );
        }).toList(),
      ),
    );
  }
}
