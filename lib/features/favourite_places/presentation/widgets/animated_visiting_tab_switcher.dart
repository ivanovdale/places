import 'package:flutter/material.dart';
import 'package:places/features/favourite_places/presentation/widgets/custom_animated_switcher.dart';

class AnimatedVisitingTabSwitcher extends StatelessWidget {
  static const double _currentTabTextStartPosition = 42;
  static const double _currentTabTextEndPosition = 241;

  static const double _tabLabelOpacityStartValue = 0.8;
  static const double _tabLabelOpacityEndValue = 0;

  late final Animation<double> _currentTabTextPositionAnimation = Tween<double>(
    begin: _currentTabTextStartPosition,
    end: _currentTabTextEndPosition,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    ),
  );

  final AnimationController animationController;
  final List<String> tabs;

  AnimatedVisitingTabSwitcher({
    super.key,
    required this.animationController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tabBarLabelStyle = theme.tabBarTheme.labelStyle?.copyWith(
      color: theme.tabBarTheme.labelColor ??
          theme.primaryTextTheme.bodyLarge?.color,
    );

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Positioned(
        top: 11,
        left: _currentTabTextPositionAnimation.value,
        child: child!,
      ),
      child: CustomAnimatedSwitcher(
        animationController: animationController,
        startOpacity: _tabLabelOpacityStartValue,
        endOpacity: _tabLabelOpacityEndValue,
        previousChild: Text(
          tabs.first,
          style: tabBarLabelStyle,
        ),
        currentChild: Text(
          tabs.last,
          style: tabBarLabelStyle,
        ),
      ),
    );
  }
}
