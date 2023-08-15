import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/features/favourite_places/presentation/widgets/animated_visiting_tab_switcher.dart';

/// TabBar для списка посещенных/планируемых к посещению мест.
class VisitingTabBar extends StatelessWidget {
  static const List<String> _tabs = [
    AppStrings.wantToVisit,
    AppStrings.visited,
  ];

  final TabController tabController;
  final AnimationController animationController;

  const VisitingTabBar({
    super.key,
    required this.tabController,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(40);
    final tabs = _tabs.map((tabName) => Tab(text: tabName)).toList();

    return Container(
      height: 40,
      margin: const EdgeInsets.only(
        top: 6,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: borderRadius,
      ),
      child: Stack(
        children: [
          TabBar(
            splashBorderRadius: borderRadius,
            controller: tabController,
            indicator: BoxDecoration(
              borderRadius: borderRadius,
              color: theme.primaryColor,
            ),
            tabs: tabs,
          ),
          AnimatedVisitingTabSwitcher(
            animationController: animationController,
            tabs: _tabs,
          ),
        ],
      ),
    );
  }
}
