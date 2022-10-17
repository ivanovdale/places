import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/providers/bottom_bar_provider.dart';
import 'package:provider/provider.dart';

/// Кастомный BottomNavigationBar.
class CustomBottomNavigationBar extends StatelessWidget {
  static const double _itemIconSize = 24.0;

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
      child: Consumer<BottomBarProvider>(
        builder: (context, viewModel, child) => BottomNavigationBar(
          items: viewModel.items.map((item) {
            return BottomNavigationBarItem(
              icon: SvgPicture.asset(
                item['icon']! as String,
                height: _itemIconSize,
                color: theme.primaryColorDark,
              ),
              activeIcon: SvgPicture.asset(
                item['activeIcon']! as String,
                height: _itemIconSize,
                color: theme.primaryColorDark,
              ),
              label: '',
            );
          }).toList(),
          currentIndex: viewModel.selectedIndex,
          onTap: (index) => viewModel.onItemTapped(index, context),
        ),
      ),
    );
  }
}
