import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/domain/repository/place_repository.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_app_bar.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/features/place_search/domain/place_search_interactor.dart';
import 'package:places/features/place_search/presentation/bloc/place_search_bloc.dart';
import 'package:places/features/place_search/presentation/widgets/place_search_bar.dart';
import 'package:places/features/place_search/presentation/widgets/search_results_or_history.dart';
import 'package:places/mocks.dart' as mocked;

/// Экран поиска мест.
///
/// Отображает поле поиска мест, историю поиска, найденные места.
/// Позволяет очистить историю поиска.
/// Позволяет перейти в детальную информацию места.
///
/// Хранит фильтры, которые будут учитываться при поиске мест.
class PlaceSearchScreen extends StatelessWidget {
  const PlaceSearchScreen({
    super.key,
  });

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
      body: BlocProvider(
        create: (_) => PlaceSearchBloc(
          placeSearchInteractor: PlaceSearchInteractor(
            context.read<PlaceRepository>(),
          ),
          placeFiltersInteractor: context.read<PlaceFiltersInteractor>(),
        )..add(
            PlaceSearchStarted(
              userCoordinates: mocked.userCoordinates,
            ),
          ),
        child: const _PlaceSearchBody(),
      ),
    );
  }
}

/// Отображает историю поиска, найденные места.
/// Позволяет очистить историю поиска.
/// Позволяет перейти в детальную информацию места.
class _PlaceSearchBody extends StatefulWidget {
  const _PlaceSearchBody();

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
    final bloc = context.read<PlaceSearchBloc>();
    final searchString = _searchController.text.trim();
    bloc.add(
      SearchStringUpdated(searchString),
    );

    if (searchString.isNotEmpty) {
      bloc.add(
        SearchMade(searchString),
      );
    }
  }

  void _fillSearchField(Place place) {
    final placeName = place.name;
    _searchController
      ..text = placeName
      ..selection = TextSelection.collapsed(
        offset: placeName.length,
      );
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
        BlocBuilder<PlaceSearchBloc, PlaceSearchState>(
          builder: (_, state) {
            final bloc = context.read<PlaceSearchBloc>();

            return SearchResultsOrHistory(
              searchHistory: state.searchHistory,
              searchString: state.searchString,
              placesFoundList: state.placesFoundList,
              isSearchStringEmpty: state.isSearchStringEmpty,
              isSearchQueryInProgress: state.isSearchInProgress,
              onPlacesFoundItemPressed: (place) => bloc.add(
                ToSearchHistoryAdded(place),
              ),
              onDeleteHistorySearchItemPressed: (place) => bloc.add(
                FromSearchHistoryRemoved(place),
              ),
              onClearHistoryPressed: () => bloc.add(
                SearchHistoryCleared(),
              ),
              onHistorySearchItemPressed: _fillSearchField,
            );
          },
        ),
      ],
    );
  }
}
