import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/coordinate_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/components/custom_app_bar.dart';
import 'package:places/ui/screens/components/custom_elevated_button.dart';
import 'package:places/ui/screens/components/custom_text_button.dart';
import 'package:places/utils/string_extension.dart';

/// Для указания минимального и максимального значения слайдера расстояния.
const minRangeValue = 0.1;
const maxRangeValue = 10.0;

/// Время активации фильтра по расстоянию до места.
const applianceDistanceFilterDelayInMillis = 500;

/// Значение по умолчанию для всех фильтров по категории места.
const allCategoriesFiltersActivated = false;

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedFiltersScreenState extends InheritedWidget {
  final _FiltersScreenState data;

  const _InheritedFiltersScreenState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedFiltersScreenState old) {
    return true;
  }

  static _FiltersScreenState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            _InheritedFiltersScreenState>() as _InheritedFiltersScreenState)
        .data;
  }
}

/// Отображает возможные фильтры мест - категория места и расстояние до места.
/// Расстояние может быть задано в некотором диапазоне.
/// Показывает количество мест после фильтрации.
/// Позволяет очистить все фильтры сразу.
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

/// Состояние экрана фильтров мест.
///
/// Хранит:
/// * [listOfCategoriesFilters] - список фильтров по категории мест.
/// Содержит имя категории, флаг активирован или не активирован, путь к картинке,
/// обозначающей категорию;
/// * [numberOfFilteredPlaces] - количество мест после фильтрации;
/// * [distanceFrom] - нижняя граница расстояния до места;
/// * [distanceTo] - верхняя граница расстояния до места.
class _FiltersScreenState extends State<FiltersScreen> {
  // TODO(daniiliv): Координаты пользователя. Потом заменятся реальными координатами.
  final CoordinatePoint _userCoordinates =
      CoordinatePoint(lat: 30.304772, lon: 59.909876);

  /// Список категорий на основании перечисления типов мест.
  List<Map> listOfCategoriesFilters = SightTypes.values
      .map((sightType) => {
            'name': sightType.name,
            'imagePath': sightType.imagePath,
            'selected': allCategoriesFiltersActivated,
          })
      .toList();
  late int numberOfFilteredPlaces;
  double distanceFrom = minRangeValue;
  double distanceTo = maxRangeValue;

  /// Таймер, откладывающий применение фильтров при использовании слайдера.
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    setNumberOfFilteredPlaces();
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
          setState(setNumberOfFilteredPlaces);
        },
      );
    });
  }

  /// Задаёт фильтрацию по категории мест.
  /// Активирует флаг активации фильтра. Далее на основании взведённых флагов
  /// выпоняет фильтрацию мест по категории.
  void setCategoriesFilters(int index) {
    setState(() {
      listOfCategoriesFilters[index]['selected'] =
          !(listOfCategoriesFilters[index]['selected'] as bool);
      setNumberOfFilteredPlaces();
    });
  }

  /// Сбрасывает все фильтры до значений по умолчанию.
  void resetAllFilters() {
    setState(() {
      for (final item in listOfCategoriesFilters) {
        item['selected'] = allCategoriesFiltersActivated;
      }
      distanceFrom = minRangeValue;
      distanceTo = maxRangeValue;
      setNumberOfFilteredPlaces();
    });
  }

  /// Задаёт количество мест после фильтрации.
  void setNumberOfFilteredPlaces() {
    numberOfFilteredPlaces = getFilteredByCategoriesAndRadiusPlacesNumber();
  }

  /// Возвращает количество мест после фильтрации по категории и расстоянию.
  int getFilteredByCategoriesAndRadiusPlacesNumber() {
    final selectedCategoriesFilters = listOfCategoriesFilters
        .where((categoriesFilter) => categoriesFilter['selected'] as bool)
        .toList()
        .map((categoriesFilter) => categoriesFilter['name'] as String)
        .toList();

    return mocks
        .where((sight) => selectedCategoriesFilters.contains(sight.type.name))
        .where((sight) => arePointInsideRadius(
              sight.coordinatePoint,
              _userCoordinates,
              distanceFrom,
              distanceTo,
            ))
        .toList()
        .length;
  }

  /// Возвращает признак, находится ли точка [checkPoint] внутри окружности
  /// с нижней границей [radiusFrom] и верхней [radiusTo]. Центр окружности [centerPoint].
  bool arePointInsideRadius(
    CoordinatePoint checkPoint,
    CoordinatePoint centerPoint,
    double radiusFrom,
    double radiusTo,
  ) {
    const ky = 40000 / 360;
    final kx = cos(pi * centerPoint.lat / 180.0) * ky;
    final dx = (centerPoint.lon - checkPoint.lon).abs() * kx;
    final dy = (centerPoint.lat - checkPoint.lat).abs() * ky;

    final calculatedDistance = sqrt(dx * dx + dy * dy);

    return calculatedDistance >= radiusFrom && calculatedDistance <= radiusTo;
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
          _CategoriesText(),
          _CategoriesFilters(),
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
    final numberOfFilteredPlaces = dataStorage.numberOfFilteredPlaces;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 24.0,
      ),
      child: CustomElevatedButton(
        '${AppStrings.show} ($numberOfFilteredPlaces)',
        textStyle: AppTypography.roboto14Regular.copyWith(
          color: Theme.of(context).colorScheme.background,
        ),
        height: 48,
      ),
    );
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
            style: AppTypography.roboto16Regular.copyWith(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            'от $valueFrom до $valueTo км',
            style: AppTypography.roboto16Regular.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w400,
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
        if (kDebugMode) {
          print('"Back" button pressed.');
        }
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

    return CustomTextButton(
      AppStrings.clear,
      textStyle: AppTypography.roboto16Regular.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.only(right: 16.0),
      onPressed: dataStorage.resetAllFilters,
    );
  }
}

/// Заголовок фильтров по категории места.
class _CategoriesText extends StatelessWidget {
  const _CategoriesText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Text(
          AppStrings.categories,
          style: AppTypography.roboto12Regular.copyWith(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.56),
            fontWeight: FontWeight.w400,
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
class _CategoriesFilters extends StatelessWidget {
  const _CategoriesFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final listOfFilters = dataStorage.listOfCategoriesFilters;

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
          return Column(
            children: [
              InkWell(
                onTap: () => dataStorage.setCategoriesFilters(index),
                child: _FilterCircle(
                  imagePath: listOfFilters[index]['imagePath'] as String,
                  selected: listOfFilters[index]['selected'] as bool,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                ),
                child: Text(
                  (listOfFilters[index]['name'] as String).capitalize(),
                  style: AppTypography.roboto12Regular.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Круглая картинка категории с пометкой активации фильтра.
class _FilterCircle extends StatelessWidget {
  final String imagePath;
  final bool selected;

  const _FilterCircle({
    Key? key,
    required this.imagePath,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: Container(
            height: 64,
            width: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.16),
            ),
            child: SvgPicture.asset(
              imagePath,
              height: 32,
              width: 32,
              color: Theme.of(context).colorScheme.primary,
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
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                Icons.done,
                size: 16,
                color: Theme.of(context).scaffoldBackgroundColor,
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

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 2,
        thumbColor: Theme.of(context).colorScheme.background,
        tickMarkShape: SliderTickMarkShape.noTickMark,
      ),
      child: RangeSlider(
        inactiveColor:
            Theme.of(context).colorScheme.secondary.withOpacity(0.56),
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
