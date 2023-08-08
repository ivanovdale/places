import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';

/// TabBar для списка посещенных/планируемых к посещению мест.
class VisitingTabBar extends StatelessWidget {
  const VisitingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 40,
      margin: const EdgeInsets.only(
        top: 6,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(40),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: theme.primaryColor,
        ),
        indicatorWeight: 0,
        tabs: const [
          Tab(
            text: AppStrings.wantToVisit,
          ),
          Tab(
            text: AppStrings.visited,
          ),
        ],
      ),
    );
  }
}
