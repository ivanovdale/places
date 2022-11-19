import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/visiting_sight_list/to_visit_sight_list.dart';
import 'package:places/UI/screens/components/visiting_sight_list/visited_sight_list.dart';
import 'package:places/UI/screens/components/visiting_sight_list/visiting_tab_bar.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:places/ui/screens/components/custom_app_bar.dart';
import 'package:places/ui/screens/components/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

/// Экран списка посещенных/планируемых к посещению мест.
///
/// Имеет TabBar для переключения между списками.
class VisitingSightsScreen extends StatelessWidget {
  const VisitingSightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.visitingScreenAppBarTitle,
          titleTextStyle: Theme.of(context).textTheme.subtitle1,
          centerTitle: true,
          toolbarHeight: 56.0,
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              const VisitingTabBar(),
              Expanded(
                child: Consumer<VisitingProvider>(
                  builder: (context, viewModel, child) => TabBarView(children: [
                    ToVisitSightList(viewModel),
                    VisitedSightList(viewModel),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
