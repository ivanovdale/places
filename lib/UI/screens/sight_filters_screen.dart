import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/utils/string_extension.dart';
import 'package:places/utils/work_with_places_mixin.dart';

/// Для указания минимального и максимального значения слайдера расстояния.
const minRangeValue = 0.1;
const maxRangeValue = 10.0;

/// Время активации фильтра по расстоянию до места.
const applianceDistanceFilterDelayInMillis = 500;

/// Значение по умолчанию для всех фильтров по категории места.
const areAllSightTypeFiltersActivated = true;

/// Экран выбора фильтров достопримечательностей.
///
/// Отображает возможные фильтры мест - категория места и расстояние до места.
/// Расстояние может быть задано в некотором диапазоне.
/// Показывает количество мест после фильтрации.
/// Позволяет очистить все фильтры сразу.
///
/// В конструктор могут быть переданы фильтры, которые нужно активировать при отрисовке экрана.
class SightFiltersScreen extends StatefulWidget {
  /// Список фильтров по категории мест.
  /// Содержит имя категории, флаг активирован или не активирован, путь к картинке,
  /// обозначающей категорию;
  final List<Map<String, Object>>? sightTypeFilters;
  final double? distanceFrom;
  final double? distanceTo;

  const SightFiltersScreen({
    Key? key,
    this.sightTypeFilters,
    this.distanceFrom,
    this.distanceTo,
  }) : super(key: key);

  @override
  _SightFiltersScreenState createState() => _SightFiltersScreenState();
}

/// Состояние экрана фильтров мест.
///
/// Хранит:
/// * [sightTypeFilters] - список фильтров по категории мест.
/// Содержит имя категории, флаг активирован или не активирован, путь к картинке,
/// обозначающей категорию;
/// * [filteredSightsNumber] - количество мест после фильтрации;
/// * [distanceFrom] - нижняя граница расстояния до места;
/// * [distanceTo] - верхняя граница расстояния до места.
class _SightFiltersScreenState extends State<SightFiltersScreen>
    with WorkWithPlaces {
  /// Список фильтров по категории мест.
  /// Содержит имя категории, флаг активирован или не активирован, путь к картинке,
  /// обозначающей категорию;
  late List<Map<String, Object>> sightTypeFilters;
  late int filteredSightsNumber;
  late double distanceFrom;
  late double distanceTo;

  /// Таймер, откладывающий применение фильтров при использовании слайдера.
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    initializeAllFilters();
    setFilteredSightsNumber();
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

  /// Выполняет инициализацию фильтров.
  void initializeAllFilters() {
    // Задать радиус по умолчанию, если он не передан в конструктор.
    distanceFrom = widget.distanceFrom ?? minRangeValue;
    distanceTo = widget.distanceTo ?? maxRangeValue;

    // Формирование списка фильтров.
    sightTypeFilters = SightTypes.values.map((sightType) {
      // Значение выбора фильтра по умолчанию.
      var isCurrentSightTypeSelected = areAllSightTypeFiltersActivated;

      // Если заданы выбранные категории, то необходимо их отметить как выбранные.
      final areSightTypeFiltersSelected = widget.sightTypeFilters != null;
      if (areSightTypeFiltersSelected) {
        isCurrentSightTypeSelected =
            isSightTypeFilterSelected(widget.sightTypeFilters!, sightType.name);
      }

      // Возвращаемый элемент мапы. Имя типа места, путь до картинки, признак выбора фильтра.
      return <String, Object>{
        'name': sightType.name,
        'imagePath': sightType.imagePath,
        'selected': isCurrentSightTypeSelected,
      };
    }).toList();
  }

  /// Задаёт фильтр по расстоянию до места на основании нижней [valueFrom] и
  /// верхней границы [valueTo]. С помощью таймера [_debounce] откладывает применение фильтра.
  void setDistanceFilters(double valueFrom, double valueTo) {
    setState(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();

      distanceFrom = valueFrom;
      distanceTo = valueTo;

      _debounce = Timer(
        const Duration(milliseconds: applianceDistanceFilterDelayInMillis),
        () {
          setState(setFilteredSightsNumber);
        },
      );
    });
  }

  /// Задаёт фильтрацию по категории мест.
  /// Активирует флаг активации фильтра по заданному индексу - [index].
  /// Далее на основании взведённых флагов выпоняет фильтрацию мест по категории.
  void setSightTypeFilterSelection(int index) {
    setState(() {
      sightTypeFilters[index]['selected'] =
          !(sightTypeFilters[index]['selected'] as bool);

      setFilteredSightsNumber();
    });
  }

  /// Сбрасывает все фильтры.
  void resetAllFilters() {
    setState(() {
      for (final item in sightTypeFilters) {
        item['selected'] = false;
      }
      distanceFrom = minRangeValue;
      distanceTo = maxRangeValue;
      setFilteredSightsNumber();
    });
  }

  /// Задаёт количество мест после фильтрации.
  void setFilteredSightsNumber() {
    filteredSightsNumber = getFilteredBySightTypeAndRadiusSightsNumber();
  }

  /// Возвращает количество мест после фильтрации по категории и расстоянию.
  int getFilteredBySightTypeAndRadiusSightsNumber() {
    final range = {
      'distanceFrom': distanceFrom,
      'distanceTo': distanceTo,
    };

    return getFilteredByTypeAndRadiusSights(
      mocked.sights,
      sightTypeFilters,
      mocked.userCoordinates,
      range,
    ).length;
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedFiltersScreenState extends InheritedWidget {
  final _SightFiltersScreenState data;

  const _InheritedFiltersScreenState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedFiltersScreenState old) {
    return true;
  }

  static _SightFiltersScreenState of(BuildContext context) {
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
          _SightTypesText(),
          _SightTypeFilters(),
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
    final filteredSightsNumber = dataStorage.filteredSightsNumber;

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
        '${AppStrings.show} ($filteredSightsNumber)',
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
    final distanceFrom = dataStorage.distanceFrom;
    final distanceTo = dataStorage.distanceTo;

    final selectedFilters = <String, Object>{
      'sightTypeFilters': dataStorage.sightTypeFilters,
      'distanceFrom': distanceFrom,
      'distanceTo': distanceTo,
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
    final valueFrom = dataStorage.distanceFrom;
    final valueTo = dataStorage.distanceTo;

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
            'от $valueFrom до $valueTo км',
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
class _SightTypesText extends StatelessWidget {
  const _SightTypesText({Key? key}) : super(key: key);

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
          AppStrings.sightTypes,
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
class _SightTypeFilters extends StatelessWidget {
  const _SightTypeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final listOfFilters = dataStorage.sightTypeFilters;
    final mediaQuery = MediaQuery.of(context);

    // Для больших экранов отображать фильтры мест в виде сетки.
    // А для экранов малого размера - в виде скролящейся строки.
    return mediaQuery.size.width > 332
        ? _SightTypeFiltersGridView(listOfFilters: listOfFilters)
        : _SightTypeFiltersScrollableRow(listOfFilters: listOfFilters);
  }
}

/// Отображает фильтры достопримечательностей в виде сетки.
class _SightTypeFiltersGridView extends StatelessWidget {
  final List<Map<String, Object>> listOfFilters;

  const _SightTypeFiltersGridView({
    Key? key,
    required this.listOfFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          final sightFilterLabel =
              (listOfFilters[index]['name'] as String).capitalize();

          return _SightFilterItem(
            sightFilterLabel: sightFilterLabel,
            index: index,
          );
        },
      ),
    );
  }
}

/// Отображает фильтры достопримечательностей в виде скролящейся строки.
class _SightTypeFiltersScrollableRow extends StatelessWidget {
  final List<Map<String, Object>> listOfFilters;

  const _SightTypeFiltersScrollableRow({
    Key? key,
    required this.listOfFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < listOfFilters.length; index++)
            Padding(
              padding: const EdgeInsets.only(right: 44.0),
              child: _SightFilterItem(
                sightFilterLabel:
                    (listOfFilters[index]['name'] as String).capitalize(),
                index: index,
              ),
            ),
        ],
      ),
    );
  }
}

/// Отображает кликабельную иконку фильтра и его наименование.
class _SightFilterItem extends StatelessWidget {
  final int index;
  final String sightFilterLabel;

  const _SightFilterItem({
    Key? key,
    required this.sightFilterLabel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FilterCircle(
          filterItemIndex: index,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
          ),
          child: Text(
            sightFilterLabel,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}

/// Круглая картинка категории с пометкой активации фильтра.
class _FilterCircle extends StatelessWidget {
  final int filterItemIndex;

  const _FilterCircle({
    Key? key,
    required this.filterItemIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final sightTypeFilters = dataStorage.sightTypeFilters;
    final imagePath = sightTypeFilters[filterItemIndex]['imagePath'] as String;
    final selected = sightTypeFilters[filterItemIndex]['selected'] as bool;

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
            onTap: () =>
                dataStorage.setSightTypeFilterSelection(filterItemIndex),
            child: ClipOval(
              child: Container(
                height: 64,
                width: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorSchemePrimaryColor.withOpacity(0.16),
                ),
                child: SvgPicture.asset(
                  imagePath,
                  height: 32,
                  width: 32,
                  color: colorSchemePrimaryColor,
                ),
              ),
            ),
          ),
        ),
        if (selected)
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
    final valueFrom = dataStorage.distanceFrom;
    final valueTo = dataStorage.distanceTo;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 2,
        thumbColor: colorScheme.background,
        tickMarkShape: SliderTickMarkShape.noTickMark,
      ),
      child: RangeSlider(
        inactiveColor: colorScheme.secondary.withOpacity(0.56),
        divisions: 99,
        min: 0.1,
        max: 10,
        onChanged: (currentValue) {
          final valueFrom = double.parse(currentValue.start.toStringAsFixed(1));
          final valueTo = double.parse(currentValue.end.toStringAsFixed(1));
          dataStorage.setDistanceFilters(valueFrom, valueTo);
        },
        values: RangeValues(valueFrom, valueTo),
      ),
    );
  }
}
