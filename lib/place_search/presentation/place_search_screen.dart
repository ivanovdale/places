import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/place_search/presentation/redux/place_search_actions.dart';
import 'package:places/place_search/presentation/redux/place_search_state.dart';
import 'package:places/place_search/presentation/widgets/place_search_bar.dart';
import 'package:places/place_search/presentation/widgets/search_results_or_history.dart';
import 'package:places/utils/redux_store_ext.dart';

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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _addListenerToUpdatePlacesFoundList();
  }

  /// Обновляет список найденных мест.
  /// Когда вводится текст в строку поиска, взводится флаг, что поиск в процессе.
  /// Когда были найдены места, то флаг поиска убирается.
  /// Если строка поиска пустая, то ничего не делать.
  void _addListenerToUpdatePlacesFoundList() {
    _searchController.addListener(_updatePlacesListener);
  }

  void _updatePlacesListener() {
    final store = context.reduxStore;
    final searchString = _searchController.text.trim();
    store.dispatch(
      UpdateSearchString(
        searchString,
      ),
    );

    if (searchString.isNotEmpty) {
      store.dispatch(
        MakeSearch(searchString),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlaceSearchBar(
          controller: _searchController,
          onPressed: _searchController.clear,
        ),
        StoreBuilder<PlaceSearchState>(
          onInit: (store) => store.dispatch(
            InitializeSearchFilters(
              placeTypeFilters: widget.placeTypeFilters.toList(),
              radius: widget.radius,
              userCoordinates: mocked.userCoordinates,
            ),
          ),
          builder: (context, store) {
            final state = store.state;

            return SearchResultsOrHistory(
              searchHistory: state.searchHistory,
              searchString: state.searchString,
              placesFoundList: state.placesFoundList,
              onPlacesFoundItemPressed: (place) => store.dispatch(
                ToggleSearchHistory(place),
              ),
              isSearchStringEmpty: state.isSearchStringEmpty,
              isSearchQueryInProgress: state.isSearchInProgress,
              onClearHistoryPressed: () => store.dispatch(
                ClearSearchHistory(),
              ),
              onHistorySearchItemPressed: (place) => store.dispatch(
                FillSearchString(place),
              ),
              onDeleteHistorySearchItemPressed: (place) => store.dispatch(
                ToggleSearchHistory(
                  place,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
