import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/providers/interactor_provider.dart';
import 'package:places/utils/string_extension.dart';
import 'package:places/utils/work_with_places_mixin.dart';
import 'package:provider/provider.dart';

/// Для указания минимального и максимального значения слайдера расстояния.
const minRangeValue = 0.1;
const maxRangeValue =
    10000001.1; // 0.1 в конце добавляется для правильной работы бэкенда (костыль)

/// Время активации фильтра по расстоянию до места.
const applianceDistanceFilterDelayInMillis = 500;

/// Экран выбора фильтров места.
///
/// Отображает возможные фильтры мест - категория места и расстояние до места.
/// Показывает количество мест после фильтрации.
/// Позволяет очистить все фильтры сразу.
///
/// В конструктор могут передаваться фильтры, которые нужно активировать при отрисовке экрана.
class PlaceFiltersScreen extends StatefulWidget {
  /// Список выбранных фильтров по категории мест.
  final Set<PlaceTypes> selectedPlaceTypeFilters;

  /// Радиус поиска места.
  final double radius;

  const PlaceFiltersScreen({
    Key? key,
    required this.selectedPlaceTypeFilters,
    required this.radius,
  }) : super(key: key);

  @override
  _PlaceFiltersScreenState createState() => _PlaceFiltersScreenState();
}

/// Состояние экрана фильтров мест.
///
/// Хранит:
/// * [selectedPlaceTypeFilters] - список выбранных фильтров по категории мест.
/// * [filteredPlacesNumber] - количество мест после фильтрации;
/// * [radius] - расстояние до места.
class _PlaceFiltersScreenState extends State<PlaceFiltersScreen>
    with WorkWithPlaces {
  /// Список выбранных фильтров по категории мест.
  late Set<PlaceTypes> selectedPlaceTypeFilters;

  /// Радиус поиска места.
  late double radius;

  /// Количество найденных мест.
  int filteredPlacesNumber = 0;

  /// Таймер, откладывающий применение фильтров при использовании слайдера.
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    initializeFilters();
    // TODO(daniiliv): Для ревью. Делать сетстейт здесь - хорошее решение?
    setFilteredPlacesNumber().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedFiltersScreenState(
      data: this,
      child: const Scaffold(
        appBar: CustomAppBar(
          toolbarHeight: 56,
          leading: _BackButton(),
          actions: [
            _ClearButton(),
          ],
        ),
        body: _FiltersBody(),
      ),
    );
  }

  /// Применяет фильтр по расстоянию до места на основании верхней границы [radius].
  /// С помощью таймера [_debounce] откладывает применение фильтра.
  void applyDistanceFilter(double radius) {
    setState(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();

      this.radius = radius;

      _debounce = Timer(
        const Duration(milliseconds: applianceDistanceFilterDelayInMillis),
        () {
          setState(setFilteredPlacesNumber);
        },
      );
    });
  }

  /// Задаёт фильтрацию по категории мест.
  /// Если фильтр есть в выбранных значениях, то убирает его.
  /// Если фильтра нет, то добавляет в выбранные значения.
  /// Далее на основании выбранных типов мест выпоняет фильтрацию мест по категории.
  void setPlaceTypeFilterSelection(PlaceTypes placeType) {
    if (selectedPlaceTypeFilters.contains(placeType)) {
      selectedPlaceTypeFilters.remove(placeType);
    } else {
      selectedPlaceTypeFilters.add(placeType);
    }
    setFilteredPlacesNumber();
  }

  /// Сбрасывает все фильтры.
  void resetAllFilters() {
    setState(() {
      selectedPlaceTypeFilters.clear();
      radius = maxRangeValue;
      setFilteredPlacesNumber();
    });
  }

  /// Задаёт количество мест после фильтрации.
  Future<void> setFilteredPlacesNumber() async {
    filteredPlacesNumber = await getFilteredByPlaceTypeAndRadiusPlacesNumber();

    setState(() {});
  }

  /// Начальная инициализация фильтров.
  void initializeFilters() {
    radius = widget.radius;
    selectedPlaceTypeFilters = widget.selectedPlaceTypeFilters;
  }

  /// Возвращает количество мест после фильтрации по категории и расстоянию.
  Future<int> getFilteredByPlaceTypeAndRadiusPlacesNumber() async {
    final placeFilterRequest = PlacesFilterRequest(
      coordinatePoint: mocked.userCoordinates,
      radius: radius,
      typeFilter: selectedPlaceTypeFilters.toList(),
    );

    final places = await context
        .read<InteractorProvider>()
        .placeInteractor
        .getFilteredPlaces(placeFilterRequest);

    return places.length;
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedFiltersScreenState extends InheritedWidget {
  final _PlaceFiltersScreenState data;

  const _InheritedFiltersScreenState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedFiltersScreenState old) {
    return true;
  }

  static _PlaceFiltersScreenState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            _InheritedFiltersScreenState>() as _InheritedFiltersScreenState)
        .data;
  }
}

/// Отображает список возможных фильтров.
/// Фильтры по категории, по расстоянию, заданному диапазоном.
class _FiltersBody extends StatelessWidget {
  const _FiltersBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: const [
          _PlaceTypesText(),
          _PlaceTypeFilters(),
          _DistanceFilterText(),
          _DistanceFilterSlider(),
          Spacer(),
          _ShowPlacesElevatedButton(),
        ],
      ),
    );
  }
}

/// Кнопка "Показать" отфильтрованные места.
class _ShowPlacesElevatedButton extends StatelessWidget {
  const _ShowPlacesElevatedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final filteredPlacesNumber = dataStorage.filteredPlacesNumber;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final buttonTextColor = colorScheme.background;
    final buttonBackgroundColor = colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 24.0,
      ),
      child: CustomElevatedButton(
        '${AppStrings.show} ($filteredPlacesNumber)',
        textStyle: theme.textTheme.bodyText2?.copyWith(
          color: buttonTextColor,
        ),
        backgroundColor: buttonBackgroundColor,
        height: 48,
        onPressed: () => applyFilters(context),
      ),
    );
  }

  /// Возвращает выбранные фильтры на предыдущий экран, где они будут применены.
  void applyFilters(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final radius = dataStorage.radius;

    final selectedFilters = <String, Object>{
      'placeTypeFilters': dataStorage.selectedPlaceTypeFilters,
      'radius': radius,
    };

    Navigator.of(context).pop(selectedFilters);
  }
}

/// Заголовок фильтра по расстоянию. Отображает расстояние от и до.
class _DistanceFilterText extends StatelessWidget {
  const _DistanceFilterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final radius = dataStorage.radius;

    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;
    final themeBodyText1 = theme.textTheme.bodyText1;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 40,
        bottom: 24,
      ),
      child: Row(
        children: [
          Text(
            AppStrings.distance,
            style: themeBodyText1,
          ),
          const Spacer(),
          Text(
            'от 0 до $radius км',
            style: themeBodyText1?.copyWith(
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Кнопка "Вернуться назад" в список интересных мест.
class _BackButton extends StatelessWidget {
  const _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 24.0,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}

/// Кнопка "Очистить" все фильтры.
class _ClearButton extends StatelessWidget {
  const _ClearButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.clear,
      textStyle: theme.textTheme.button?.copyWith(
        color: theme.colorScheme.primary,
      ),
      padding: const EdgeInsets.only(right: 16.0),
      onPressed: dataStorage.resetAllFilters,
    );
  }
}

/// Заголовок фильтров по категории места.
class _PlaceTypesText extends StatelessWidget {
  const _PlaceTypesText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary.withOpacity(0.56);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Text(
          AppStrings.placeTypes,
          style: theme.textTheme.caption?.copyWith(
            color: secondaryColor,
          ),
        ),
      ),
    );
  }
}

/// Фильтрации по категории мест.
///
/// Отображает картинки типов мест с их обозначениями.
/// Показывает, установлен ли фильтр по той или иной категории.
class _PlaceTypeFilters extends StatelessWidget {
  const _PlaceTypeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final selectedPlaceTypeFilters = dataStorage.selectedPlaceTypeFilters;
    final mediaQuery = MediaQuery.of(context);

    // Для больших экранов отображать фильтры мест в виде сетки.
    // А для экранов малого размера - в виде скролящейся строки.
    return mediaQuery.size.width > 332
        ? _PlaceTypeFiltersGridView(
            selectedPlaceTypeFilters: selectedPlaceTypeFilters,
          )
        : _PlaceTypeFiltersScrollableRow(
            selectedPlaceTypeFilters: selectedPlaceTypeFilters,
          );
  }
}

/// Отображает фильтры места в виде сетки.
class _PlaceTypeFiltersGridView extends StatelessWidget {
  final Set<PlaceTypes> selectedPlaceTypeFilters;

  const _PlaceTypeFiltersGridView({
    Key? key,
    required this.selectedPlaceTypeFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listOfFilters = PlaceTypes.values.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 40,
          crossAxisSpacing: 25,
        ),
        itemCount: listOfFilters.length,
        itemBuilder: (context, index) {
          final placeFilter = listOfFilters.elementAt(index);

          return _PlaceFilterItem(placeType: placeFilter);
        },
      ),
    );
  }
}

/// Отображает фильтры места в виде скролящейся строки.
class _PlaceTypeFiltersScrollableRow extends StatelessWidget {
  final Set<PlaceTypes> selectedPlaceTypeFilters;

  const _PlaceTypeFiltersScrollableRow({
    Key? key,
    required this.selectedPlaceTypeFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: PlaceTypes.values
            .map(
              (placeType) => Padding(
                padding: const EdgeInsets.only(right: 44.0),
                child: _PlaceFilterItem(
                  placeType: placeType,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Отображает кликабельную иконку фильтра и его наименование.
class _PlaceFilterItem extends StatelessWidget {
  final PlaceTypes placeType;

  const _PlaceFilterItem({
    Key? key,
    required this.placeType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FilterCircle(
          placeFilter: placeType,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
          ),
          child: Text(
            placeType.text.capitalize(),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}

/// Круглая картинка категории с пометкой активации фильтра.
class _FilterCircle extends StatelessWidget {
  final PlaceTypes placeFilter;

  const _FilterCircle({
    Key? key,
    required this.placeFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final selectedPlaceTypeFilters = dataStorage.selectedPlaceTypeFilters;
    final isFilterSelected = selectedPlaceTypeFilters.contains(placeFilter);

    final theme = Theme.of(context);
    final colorSchemePrimaryColor = theme.colorScheme.primary;

    return Stack(
      children: [
        Material(
          borderRadius: BorderRadius.circular(50),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: InkWell(
            onTap: () => dataStorage.setPlaceTypeFilterSelection(placeFilter),
            child: ClipOval(
              child: Container(
                height: 64,
                width: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorSchemePrimaryColor.withOpacity(0.16),
                ),
                child: SvgPicture.asset(
                  placeFilter.imagePath,
                  height: 32,
                  width: 32,
                  color: colorSchemePrimaryColor,
                ),
              ),
            ),
          ),
        ),
        if (isFilterSelected)
          Positioned(
            right: 1,
            bottom: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: theme.primaryColor,
              ),
              child: Icon(
                Icons.done,
                size: 16,
                color: theme.scaffoldBackgroundColor,
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}

/// Слайдер для фильтрации по расстоянию до места.
class _DistanceFilterSlider extends StatelessWidget {
  const _DistanceFilterSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final radiusInMeters = dataStorage.radius;
    final radiusInKilometers = radiusInMeters / 1000;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 2,
        thumbColor: colorScheme.background,
        tickMarkShape: SliderTickMarkShape.noTickMark,
      ),
      child: Slider(
        inactiveColor: colorScheme.secondary.withOpacity(0.56),
        divisions: 99,
        min: 0.1,
        max: maxRangeValue / 1000,
        onChanged: (currentValue) {
          final radiusInMeters =
              double.parse(currentValue.toStringAsFixed(1)) * 1000;
          // + 0.1 к радиусу - костыль для работы бэкенда. -_-
          dataStorage.applyDistanceFilter(radiusInMeters + 0.1);
        },
        value: radiusInKilometers,
      ),
    );
  }
}
