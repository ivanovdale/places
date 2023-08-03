import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/domain/bottom_navigation_bar_data.dart';

class CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  CustomBottomNavigationBarItem({
    required BottomNavigationBarData data,
    required double? iconSize,
    required ThemeData theme,
  }) : super(
          icon: SvgPicture.asset(
            data.icon,
            height: iconSize,
            colorFilter: ColorFilter.mode(
              theme.primaryColorDark,
              BlendMode.srcIn,
            ),
          ),
          activeIcon: SvgPicture.asset(
            data.activeIcon,
            height: iconSize,
            colorFilter: ColorFilter.mode(
              theme.primaryColorDark,
              BlendMode.srcIn,
            ),
          ),
          label: '',
        );
}
