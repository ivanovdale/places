import 'package:flutter/material.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_tab_bar.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_tab_bar_view.dart';

class VisitingTabs extends StatefulWidget {
  const VisitingTabs({super.key});

  @override
  State<VisitingTabs> createState() => _VisitingTabsState();
}

class _VisitingTabsState extends State<VisitingTabs>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _animationController;

  static const _tabSwitchingAnimationDuration = Duration(milliseconds: 350);
  static const _tabBarAnimationDuration = Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: _tabSwitchingAnimationDuration,
    );
    _animationController = AnimationController(
      vsync: this,
      duration: _tabBarAnimationDuration,
    );
    _tabController.addListener(_startAnimation);
  }

  void _startAnimation() {
    if (_tabController.previousIndex == 0) _animationController.forward();
    if (_tabController.previousIndex == 1) _animationController.reverse();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VisitingTabBar(
          tabController: _tabController,
          animationController: _animationController,
        ),
        VisitingTabBarView(
          tabController: _tabController,
        ),
      ],
    );
  }
}
