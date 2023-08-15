import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_app_bar.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_tabs.dart';

/// Экран списка посещенных/планируемых к посещению мест.
///
/// Имеет TabBar для переключения между списками.
class FavouritePlacesScreen extends StatelessWidget {
  const FavouritePlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.visitingScreenAppBarTitle,
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        toolbarHeight: 56,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: DefaultTabController(
          length: 2,
          child: VisitingTabs(),
        ),
      ),
    );
  }
}
