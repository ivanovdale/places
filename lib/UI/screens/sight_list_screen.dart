import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/UI/screens/add_sight_screen.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/search_bar.dart';
import 'package:places/UI/screens/sight_filters_screen.dart';
import 'package:places/UI/screens/sight_search_screen.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/ui/screens/components/custom_app_bar.dart';
import 'package:places/ui/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/ui/screens/components/sight_card.dart';
import 'package:places/utils/work_with_places_mixin.dart';

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
class _SightListScreenState extends State<SightListScreen> with WorkWithPlaces {
  late List<Sight> sights;
  late List<Map<String, Object>> sightTypeFilters;
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
    sightTypeFilters = SightTypes.values.map((sightType) {
      return <String, Object>{
        'name': sightType.name,
        'imagePath': sightType.imagePath,
        'selected': true,
      };
    }).toList();

    final range = {
      'distanceFrom': distanceFrom,
      'distanceTo': distanceTo,
    };
    // Фильтрация мест на основании инициализированных фильтров.
    // TODO(daniiliv): Пока в качестве источника данных - моковые данные.
    sights = getFilteredByTypeAndRadiusSights(
      mocked.sights,
      sightTypeFilters,
      mocked.userCoordinates,
      range,
    );
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

      final range = {
        'distanceFrom': distanceFrom,
        'distanceTo': distanceTo,
      };

      // Обновить новый список мест в сооветствии с фильтрами.
      // TODO(daniiliv): В качестве источника фильтрации используем моковые данные.
      sights = getFilteredByTypeAndRadiusSights(
        mocked.sights,
        sightTypeFilters,
        mocked.userCoordinates,
        range,
      );

      setState(() {});
    }
  }

  /// Применяет переданные фильтры к списку мест.
  void applyFilters(
    List<Map<String, Object>> selectedSightTypes,
    double distanceFrom,
    double distanceTo,
  ) {
    final range = {
      'distanceFrom': distanceFrom,
      'distanceTo': distanceTo,
    };
    // TODO(daniiliv): В качестве списка, к которому применяются фильтры, пока что устанавливаем моковые данные.
    sights = getFilteredByTypeAndRadiusSights(
      mocked.sights,
      selectedSightTypes,
      mocked.userCoordinates,
      range,
    );

    setState(() {});
  }

  /// Сохраняет переданные фильтры в виджете-состоянии.
  void saveFilters(
    List<Map<String, Object>> sightTypeFilters,
    double distanceFrom,
    double distanceTo,
  ) {
    this.sightTypeFilters = sightTypeFilters;
    this.distanceFrom = distanceFrom;
    this.distanceTo = distanceTo;
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Оповещает дочерние виджеты о перерисовке при изменении списка достопримечательностей.
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
    final dataStorage = _InheritedSightListScreenState.of(context);

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => SightSearchScreen(
          sightTypeFilters: dataStorage.sightTypeFilters,
          distanceFrom: dataStorage.distanceFrom,
          distanceTo: dataStorage.distanceTo,
        ),
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
        builder: (context) => SightFiltersScreen(
          sightTypeFilters: dataStorage.sightTypeFilters,
          distanceFrom: dataStorage.distanceFrom,
          distanceTo: dataStorage.distanceTo,
        ),
      ),
    );

    if (selectedFilters != null) {
      final sightTypeFilters =
          selectedFilters['sightTypeFilters'] as List<Map<String, Object>>;
      final distanceFrom = selectedFilters['distanceFrom'] as double;
      final distanceTo = selectedFilters['distanceTo'] as double;

      dataStorage
        ..saveFilters(sightTypeFilters, distanceFrom, distanceTo)
        ..applyFilters(sightTypeFilters, distanceFrom, distanceTo);
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
