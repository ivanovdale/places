import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/place_card/place_card.dart';
import 'package:places/UI/screens/components/placeholders/error_placeholder.dart';
import 'package:places/UI/screens/components/search_bar.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_router.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/providers/interactor_provider.dart';
import 'package:places/stores/place_list_store/place_list_store.dart';
import 'package:provider/provider.dart';

/// Экран списка мест.
class PlaceListScreen extends StatefulWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

/// Состояние экрана списка мест.
///
/// Обновляет список при добавлении нового места.
/// Хранит в себе значения фильтров.
class _PlaceListScreenState extends State<PlaceListScreen> {
  late PlaceListStore _store;

  @override
  void initState() {
    super.initState();

    _store = PlaceListStore(
      context.read<PlaceInteractorProvider>().placeInteractor,
    );
    _store.getFilteredPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Provider<PlaceListStore>(
      create: (context) => _store,
      child: Scaffold(
        // Скрываем боттом бар при горизонтальной ориентации.
        bottomNavigationBar: orientation == Orientation.landscape
            ? null
            : const CustomBottomNavigationBar(),
        body: const _PlaceListBody(),
        floatingActionButton: _AddNewPlaceButton(
          onPressed: () => _openAddPlaceScreen(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  /// Открывает экран добавления места.
  ///
  /// Если было создано новое место, добавляет его в список мест и обновляет экран.
  Future<void> _openAddPlaceScreen(BuildContext context) async {
    var newPlace = await Navigator.pushNamed<Place?>(
      context,
      AppRouter.addPlace,
    );

    if (newPlace != null && mounted) {
      newPlace = await context
          .read<PlaceInteractorProvider>()
          .placeInteractor
          .addNewPlace(newPlace);

      if (mounted) await context.read<PlaceListStore>().getFilteredPlaces();
    }
  }
}

/// Отображает список мест.
class _PlaceListBody extends StatelessWidget {
  const _PlaceListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        _SliverAppBar(),
        _SliverPlaceList(),
      ],
    );
  }
}

/// Кастомный аппбар на сливере.
class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPersistentHeader(
      pinned: true,
      delegate: _CustomAppBarDelegate(expandedHeight: 245),
    );
  }
}

/// Делегат кастомного аппбара.
///
/// По умолчанию аппбар состоит из крупного заголовка и строки поиска мест.
/// При сужении аппбара строка поиска мест становится невидимой, заголовок аппбара уменьшается.
class _CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 150;

  const _CustomAppBarDelegate({
    required this.expandedHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Вычисление значений параметров аппбара в зависимости от того, начал ли аппбар сужаться.
    final isScrollStarted = shrinkOffset > 0;
    final theme = Theme.of(context);
    final title = isScrollStarted
        ? AppStrings.placeListAppBarTitle
        : AppStrings.placeListAppBarTitleWithLineBreak;
    final titleTextStyle =
        isScrollStarted ? theme.textTheme.titleMedium : theme.textTheme.headlineMedium;
    final centerTitle = isScrollStarted;

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: CustomAppBar(
            title: title,
            titleTextStyle: titleTextStyle,
            centerTitle: centerTitle,
            toolbarHeight: 128,
            padding: EdgeInsets.only(
              // При сужении аппбара убираются отступы у аппбара.
              top: isScrollStarted ? 0 : 40,
              bottom: isScrollStarted ? 0 : 16,
            ),
          ),
        ),
        Expanded(
          child: Opacity(
            // При сужении аппбара строка поиска становится невидимой.
            opacity: 1 - shrinkOffset / expandedHeight,
            child: SearchBar(
              readOnly: true,
              // Не обрабатывать нажатия, когда строка поиска уже скрыта.
              onTap: isScrollStarted
                  ? null
                  : () => _navigateToPlaceSearchScreen(context),
              suffixIcon: _FilterButton(
                isButtonDisabled: isScrollStarted,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  /// Открывает экран поиска мест.
  void _navigateToPlaceSearchScreen(BuildContext context) {
    final store = context.read<PlaceListStore>();

    Navigator.pushNamed(
      context,
      AppRouter.placeSearch,
      arguments: {
        'placeTypeFilters': store.placeTypeFilters,
        'radius': store.radius,
      },
    );
  }
}

/// Список достопримечательностей на сливере.
class _SliverPlaceList extends StatelessWidget {
  const _SliverPlaceList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final screenHeight = mediaQuery.size.height;

    return Observer(
      builder: (_) {
        final store = context.read<PlaceListStore>();
        final isLoading = store.placesFuture?.status == FutureStatus.pending;
        final hasError = store.placesFuture?.error != null;

        if (!isLoading && !hasError) {
          final places = store.placesFuture?.value;

          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: places!.length,
              (_, index) {
                final place = places[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PlaceCard(
                    place,
                    toggleFavorites: () => context
                        .read<PlaceInteractorProvider>()
                        .toggleFavorites(place),
                  ),
                );
              },
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // Для горизонтальной ориентации отображаем 2 ряда карточек.
              crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
              mainAxisExtent: orientation == Orientation.portrait
                  ? screenHeight * 0.3
                  : screenHeight * 0.65,
            ),
          );
        } else if (hasError) {
          return const SliverFillRemaining(
            child: ErrorPlaceHolder(),
          );
        } else {
          return const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

/// Кнопка фильтрации достопримечательностей.
///
/// Открывает экран фильтрации, после закрытия которого применяются выбранные фильтры и обновляется текущий экран.
class _FilterButton extends StatelessWidget {
  final bool isButtonDisabled;

  const _FilterButton({
    Key? key,
    this.isButtonDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      icon: SvgPicture.asset(
        AppAssets.filter,
        fit: BoxFit.none,
        color: theme.colorScheme.primary,
      ),
      color: theme.primaryColorDark,
      onPressed:
          isButtonDisabled ? null : () => _navigateToFiltersScreen(context),
    );
  }

  /// Открывает экран фильтрации мест.
  ///
  /// После выбора фильтров сохраняет их в стейте текущего экрана и затем применяет их.
  Future<void> _navigateToFiltersScreen(BuildContext context) async {
    final store = context.read<PlaceListStore>();

    final selectedFilters = await Navigator.pushNamed<Map<String, Object>>(
      context,
      AppRouter.placeFilters,
      arguments: {
        'placeTypeFilters': store.placeTypeFilters,
        'radius': store.radius,
      },
    );

    if (selectedFilters != null) {
      final placeTypeFilters =
          selectedFilters['placeTypeFilters'] as Set<PlaceTypes>;
      final radius = selectedFilters['radius'] as double;

      store.saveFilters(placeTypeFilters, radius);
      await store.getFilteredPlaces();
    }
  }
}

/// Кнопка добавления нового места.
class _AddNewPlaceButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _AddNewPlaceButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSchemeOnBackgroundColor = theme.colorScheme.onBackground;

    return CustomElevatedButton(
      AppStrings.newPlace,
      width: 177,
      height: 48,
      buttonLabel: Icon(
        Icons.add,
        size: 20,
        color: colorSchemeOnBackgroundColor,
      ),
      borderRadius: BorderRadius.circular(24),
      textStyle: theme.textTheme.bodyMedium?.copyWith(
        color: colorSchemeOnBackgroundColor,
        fontWeight: FontWeight.w700,
      ),
      gradient: const LinearGradient(
        colors: [AppColors.brightSun, AppColors.fruitSalad],
      ),
      onPressed: onPressed,
    );
  }
}
