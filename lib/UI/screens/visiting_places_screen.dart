import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/UI/screens/components/visiting_place_list/to_visit_place_list.dart';
import 'package:places/UI/screens/components/visiting_place_list/visited_place_list.dart';
import 'package:places/UI/screens/components/visiting_place_list/visiting_tab_bar.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:provider/provider.dart';

/// Экран списка посещенных/планируемых к посещению мест.
///
/// Имеет TabBar для переключения между списками.
class VisitingPlacesScreen extends StatelessWidget {
  const VisitingPlacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.visitingScreenAppBarTitle,
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
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
                    ToVisitPlaceList(viewModel),
                    VisitedPlaceList(viewModel),
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
