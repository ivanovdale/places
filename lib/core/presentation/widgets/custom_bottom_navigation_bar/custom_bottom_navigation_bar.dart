import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/components/custom_bottom_navigation_bar_item.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/cubit/bottom_navigation_cubit.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/res/bottom_navigation_bar_items.dart';

/// Кастомный BottomNavigationBar.
class CustomBottomNavigationBar extends StatelessWidget {
  static const double _itemIconSize = 24;

  const CustomBottomNavigationBar({super.key});

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
      child: BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
        listener: (_, state) {
          Navigator.pushReplacementNamed(
            context,
            bottomNavigationBarItems[state.selectedTabIndex].routeName,
          );
        },
        builder: (_, state) => BottomNavigationBar(
          items: bottomNavigationBarItems
              .map(
                (item) => CustomBottomNavigationBarItem(
                  data: item,
                  iconSize: _itemIconSize,
                  theme: theme,
                ),
              )
              .toList(),
          currentIndex: state.selectedTabIndex,
          onTap: (index) =>
              context.read<BottomNavigationCubit>().onItemTapped(index),
        ),
      ),
    );
  }
}
