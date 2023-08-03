import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';
import 'package:places/features/place_filters/presentation/widgets/back_button.dart'
    as filters;
import 'package:places/features/place_filters/presentation/widgets/clear_button.dart';
import 'package:places/features/place_filters/presentation/widgets/distance_filter_slider.dart';
import 'package:places/features/place_filters/presentation/widgets/distance_filter_title.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/place_type_filters.dart';
import 'package:places/features/place_filters/presentation/widgets/place_types_title.dart';
import 'package:places/features/place_filters/presentation/widgets/show_places_elevated_button.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/providers/place_interactor_provider.dart';
import 'package:provider/provider.dart';

/// Для указания минимального и максимального значения слайдера расстояния.
const minRangeValue = 0.1;
const maxRangeValue =
    10000001.1; // 0.1 в конце добавляется для правильной работы бэкенда (костыль).

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
  PlaceFiltersScreenState createState() => PlaceFiltersScreenState();
}

/// Состояние экрана фильтров мест.
///
/// Хранит:
/// * [selectedPlaceTypeFilters] - список выбранных фильтров по категории мест.
/// * [filteredPlacesNumber] - количество мест после фильтрации;
/// * [radius] - расстояние до места.
class PlaceFiltersScreenState extends State<PlaceFiltersScreen> {
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
    setFilteredPlacesNumber();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedFiltersScreenState(
      data: this,
      child: const Scaffold(
        appBar: CustomAppBar(
          toolbarHeight: 56,
          leading: filters.BackButton(),
          actions: [
            ClearButton(),
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
        () => setFilteredPlacesNumber,
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
        .read<PlaceInteractorProvider>()
        .placeInteractor
        .getFilteredPlaces(placeFilterRequest);

    return places.length;
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedFiltersScreenState extends InheritedWidget {
  static PlaceFiltersScreenState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            _InheritedFiltersScreenState>() as _InheritedFiltersScreenState)
        .data;
  }

  final PlaceFiltersScreenState data;

  const _InheritedFiltersScreenState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedFiltersScreenState old) {
    return true;
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          PlaceTypesTitle(),
          PlaceTypeFilters(),
          DistanceFilterTitle(),
          DistanceFilterSlider(),
          Spacer(),
          ShowPlacesElevatedButton(),
        ],
      ),
    );
  }
}
