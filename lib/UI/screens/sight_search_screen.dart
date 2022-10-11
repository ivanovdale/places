import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/UI/screens/components/search_bar.dart';
import 'package:places/helpers/app_strings.dart';

// TODO(daniiliv): doka
class SightSearchScreen extends StatelessWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.sightListAppBarTitle,
        titleTextStyle: theme.textTheme.subtitle1?.copyWith(
          color: theme.primaryColorDark,
        ),
        centerTitle: true,
        toolbarHeight: 56,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: const _SightSearchBody(),
    );
  }
}

// TODO(daniiliv): doka
class _SightSearchBody extends StatelessWidget {
  const _SightSearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final secondaryColor = colorScheme.secondary.withOpacity(0.56);

    return Column(
      children: [
        SearchBar(
          suffixIcon: IconButton(
            icon: const Icon(Icons.cancel),
            color: theme.primaryColorDark,
            onPressed: () {}, // TODO(daniiliv): удаление текста поиска
          ),
        ),
      ],
    );
  }
}
