import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/helpers/app_assets.dart';

/// Кастомный BottomNavigationBar.
class CustomBottomNavigationBar extends StatelessWidget {
  static const double _itemIconSize = 24.0;
  static const _itemAssets = [
    AppAssets.list,
    AppAssets.map,
    AppAssets.heart,
    AppAssets.settings,
  ];

  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.secondary.withOpacity(0.56),
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
              color: theme.primaryColorDark,
            ),
            label: '',
          );
        }).toList(),
        onTap: (itemIndex) {
          if (kDebugMode) {
            print('${_itemAssets[itemIndex].split('/')[2].replaceAll('.svg', '')} in bottom nav. bar pressed.');
          }
        },
      ),
    );
  }
}
