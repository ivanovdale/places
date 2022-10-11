import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/UI/screens/add_sight_screen.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/search_bar.dart';
import 'package:places/UI/screens/filters_screen.dart';
import 'package:places/UI/screens/sight_search_screen.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/ui/screens/components/custom_app_bar.dart';
import 'package:places/ui/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/ui/screens/components/sight_card.dart';

/// Экран списка достопримечательностей.
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

/// Состояние экрана списка достопримечательстей.
///
/// Обновляет список при добавлении нового места.
/// Хранит в себе значения фильтров.
class _SightListScreenState extends State<SightListScreen> {
  late List<Sight> sights;
  late List<String> categories;
  late double distanceFrom;
  late double distanceTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.sightListAppBarTitleWithLineBreak,
        titleTextStyle: Theme.of(context).textTheme.headline4,
        toolbarHeight: 128,
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 16,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: _InheritedSightListScreenState(
        data: this,
        child: const _SightListBody(),
      ),
      floatingActionButton: _AddNewPlaceButton(
        onPressed: () => openAddSightScreen(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void initState() {
    super.initState();

    // Установим фильтры по умолчанию.
    distanceFrom = minRangeValue;
    distanceTo = maxRangeValue;

    // Категории по умолчанию.
    categories = SightTypes.values.map((sightType) => sightType.name).toList();

    // Фильтрация мест на основании инициализированных фильтров.
    // TODO(daniiliv): Пока в качестве источника данных - моковые данные.
    sights = getFilteredSights(mocked.sights, categories, distanceFrom, distanceTo);
  }

  /// Открывает экран добавления достопримечательности.
  ///
  /// Если была создана новая достопримечательность, добавляет её в список моковых достопримечательностей и обновляет экран.
  Future<void> openAddSightScreen(BuildContext context) async {
    final newSight = await Navigator.push(
      context,
      MaterialPageRoute<Sight?>(
        builder: (context) => const AddSightScreen(),
      ),
    );

    if (newSight != null) {
      mocked.sights.add(newSight);
      // Обновить новый список мест в сооветствии с фильтрами.
      // TODO(daniiliv): В качестве источника фильтрации используем моковые данные.
      sights = getFilteredSights(mocked.sights, categories, distanceFrom, distanceTo);

      setState(() {});
    }
  }

  /// Применяет переданные фильтры к списку мест.
  void applyFilters(
    List<String> selectedCategories,
    double distanceFrom,
    double distanceTo,
  ) {
    // TODO(daniiliv): В качестве списка, к которому применяются фильтры, пока что устанавливаем моковые данные.
    sights = getFilteredSights(mocked.sights, selectedCategories, distanceFrom, distanceTo);

    setState(() {});
  }

  /// Возвращает отфильтрованный список мест.
  List<Sight> getFilteredSights(
    List<Sight> sights,
    List<String> selectedCategories,
    double distanceFrom,
    double distanceTo,
  ) {
    return sights
        .where((sight) => selectedCategories.contains(sight.type.name))
        .where((sight) => sight.coordinatePoint.isPointInsideRadius(
              mocked.userCoordinates,
              distanceFrom,
              distanceTo,
            ))
        .toList();
  }

  /// Сохраняет переданные фильтры в виджете-состоянии.
  void saveFilters(
    List<String> selectedCategories,
    double distanceFrom,
    double distanceTo,
  ) {
    categories = selectedCategories;
    this.distanceFrom = distanceFrom;
    this.distanceTo = distanceTo;
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedSightListScreenState extends InheritedWidget {
  final _SightListScreenState data;

  const _InheritedSightListScreenState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedSightListScreenState old) {
    // Перерисовка экрана, если список мест обновился.
    return listEquals(old.data.sights, data.sights);
  }

  static _SightListScreenState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            _InheritedSightListScreenState>() as _InheritedSightListScreenState)
        .data;
  }
}

/// Отображает список достопримечательностей.
class _SightListBody extends StatelessWidget {
  const _SightListBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedSightListScreenState.of(context);
    final sights = dataStorage.sights;

    return Column(
      children: [
        SearchBar(
          readOnly: true,
          onTap: () => navigateToSightSearchScreen(context),
          suffixIcon: const _FilterButton(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: sights.map(SightCard.new).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Открывает экран поиска достопримечательностей.
  void navigateToSightSearchScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const SightSearchScreen(),
      ),
    );
  }
}

/// Кнопка фильтрации достопримечательностей.
///
/// Открывает экран фильтрации, после закрытия которого применяются выбранные фильтры и обновляется текущий экран.
class _FilterButton extends StatelessWidget {
  const _FilterButton({Key? key}) : super(key: key);

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
      onPressed: () => navigateToFiltersScreen(context),
    );
  }

  /// Открывает экран фильтрации мест.
  ///
  /// После выбора фильтров сохраняет их в стейте текущего экрана и затем применяет их.
  Future<void> navigateToFiltersScreen(BuildContext context) async {
    final dataStorage = _InheritedSightListScreenState.of(context);

    final selectedFilters = await Navigator.push(
      context,
      MaterialPageRoute<Map<String, Object>>(
        builder: (context) => FiltersScreen(
          selectedSightTypes: dataStorage.categories,
          distanceFrom: dataStorage.distanceFrom,
          distanceTo: dataStorage.distanceTo,
        ),
      ),
    );

    if (selectedFilters != null) {
      final categories = selectedFilters['categories'] as List<String>;
      final distanceFrom = selectedFilters['distanceFrom'] as double;
      final distanceTo = selectedFilters['distanceTo'] as double;

      dataStorage
        ..saveFilters(categories, distanceFrom, distanceTo)
        ..applyFilters(categories, distanceFrom, distanceTo);
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
      textStyle: theme.textTheme.bodyText2?.copyWith(
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
