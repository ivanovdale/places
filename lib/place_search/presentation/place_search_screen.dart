import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/data/interactor/place_search_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/repository/place_repository.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/place_search/presentation/widgets/place_search_bar.dart';
import 'package:places/place_search/presentation/widgets/search_results.dart';

/// Экран поиска мест.
///
/// Отображает поле поиска мест, историю поиска, найденные места.
/// Позволяет очистить историю поиска.
/// Позволяет перейти в детальную информацию места.
///
/// Хранит фильтры, которые будут учитываться при поиске мест.
class PlaceSearchScreen extends StatelessWidget {
  final Set<PlaceTypes> placeTypeFilters;
  final double radius;

  const PlaceSearchScreen({
    Key? key,
    required this.placeTypeFilters,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.placeListAppBarTitle,
        titleTextStyle: theme.textTheme.titleMedium?.copyWith(
          color: theme.primaryColorDark,
        ),
        centerTitle: true,
        toolbarHeight: 56,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: _PlaceSearchBody(
        placeTypeFilters: placeTypeFilters,
        radius: radius,
      ),
    );
  }
}

/// Отображает историю поиска, найденные места.
/// Позволяет очистить историю поиска.
/// Позволяет перейти в детальную информацию места.
class _PlaceSearchBody extends StatefulWidget {
  final Set<PlaceTypes> placeTypeFilters;
  final double radius;

  const _PlaceSearchBody({
    Key? key,
    required this.placeTypeFilters,
    required this.radius,
  }) : super(key: key);

  @override
  State<_PlaceSearchBody> createState() => _PlaceSearchBodyState();
}

/// Хранит состояние поиска мест.
class _PlaceSearchBodyState extends State<_PlaceSearchBody> {
  final PlaceSearchInteractor _placeSearchInteractor =
      PlaceSearchInteractor(GetIt.instance.get<PlaceRepository>());

  final TextEditingController _searchController = TextEditingController();

  /// Найденные места.
  late List<Place> _placesFoundList = [];

  /// Флаг начала процесса поиска мест.
  bool _isSearchQueryInProgress = false;

  /// Данные строки поиска.
  String _searchString = '';

  @override
  void initState() {
    super.initState();
    _initializeFiltersAndUserCoordinates();
    _addListenerToUpdatePlacesFoundList();
  }

  /// Устанавливает параметры поиска и координаты пользователя для интерактора.
  void _initializeFiltersAndUserCoordinates() {
    _placeSearchInteractor
      ..typeFilter = widget.placeTypeFilters.toList()
      ..radius = widget.radius
      ..userCoordinates = mocked.userCoordinates;
  }

  /// Обновляет список найденных мест.
  /// Когда вводится текст в строку поиска, взводится флаг, что поиск в процессе.
  /// Когда были найдены места, то флаг поиска убирается.
  /// Если строка поиска пустая, то ничего не делать.
  void _addListenerToUpdatePlacesFoundList() {
    _searchController.addListener(_updatePlacesListener);
  }

  void _updatePlacesListener() => _updatePlacesFoundList();

  Future<void> _updatePlacesFoundList() async {
    _searchString = _searchController.text.trim();
    if (_searchString.isNotEmpty) {
      setState(() {
        _isSearchQueryInProgress = true;
      });

      await _applyAllFilters(_searchString);
      setState(() {
        _isSearchQueryInProgress = false;
      });
    } else {
      setState(() {});
    }
  }

  /// Очищает поле поиска.
  void _clearSearchText() {
    _searchController.clear();
  }

  /// Удаляет элемент из списка истории поиска.
  void _deleteFromSearchHistory(Place place) {
    _placeSearchInteractor.removeFromSearchHistory(place);

    setState(() {});
  }

  /// Удаляет все элементы из списка истории поиска.
  void _deleteAllItemsFromSet() {
    _placeSearchInteractor.clearSearchHistory();

    setState(() {});
  }

  /// Заполняет поле поиска переданной строкой.
  void _fillSearchFieldWithItem(Place place) {
    _searchController.text = place.name;

    setState(() {});
  }

  /// Применяет фильтрацию по всем текущим параметрам.
  Future<void> _applyAllFilters(String searchString) async {
    _placesFoundList =
        await _placeSearchInteractor.getFilteredPlaces(searchString);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataStorage = this;
    final isSearchStringEmpty = _searchString.isEmpty;
    final searchHistory = _placeSearchInteractor.searchHistory;

    return Column(
      children: [
        PlaceSearchBar(
          controller: _searchController,
          onPressed: _clearSearchText,
        ),
        SearchResults(
          searchHistory: searchHistory,
          searchString: _searchString,
          placesFoundList: _placesFoundList,
          onPlacesFoundItemPressed:
              dataStorage._placeSearchInteractor.addToSearchHistory,
          isSearchStringEmpty: isSearchStringEmpty,
          isSearchQueryInProgress: _isSearchQueryInProgress,
          onClearHistoryPressed: dataStorage._deleteAllItemsFromSet,
          onHistorySearchItemPressed: _fillSearchFieldWithItem,
          onDeleteHistorySearchItemPressed:
              dataStorage._deleteFromSearchHistory,
        ),
      ],
    );
  }
}
