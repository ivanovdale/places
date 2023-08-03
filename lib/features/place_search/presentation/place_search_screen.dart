import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/repository/place_repository.dart';
import 'package:places/features/place_search/domain/place_search_interactor.dart';
import 'package:places/features/place_search/presentation/bloc/place_search_bloc.dart';
import 'package:places/features/place_search/presentation/widgets/place_search_bar.dart';
import 'package:places/features/place_search/presentation/widgets/search_results_or_history.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;

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
      body: BlocProvider(
        create: (context) => PlaceSearchBloc(
          PlaceSearchInteractor(
            context.read<PlaceRepository>(),
          ),
        )..add(
            PlaceSearchStarted(
              placeTypeFilters: placeTypeFilters.toList(),
              radius: radius,
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
  const _PlaceSearchBody({
    Key? key,
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
    final bloc = context.read<PlaceSearchBloc>();
    final searchString = _searchController.text.trim();
    bloc.add(
      UpdateSearchString(searchString),
    );

    if (searchString.isNotEmpty) {
      bloc.add(
        MakeSearch(searchString),
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
          builder: (context, state) {
            final bloc = context.read<PlaceSearchBloc>();

            return SearchResultsOrHistory(
              searchHistory: state.searchHistory,
              searchString: state.searchString,
              placesFoundList: state.placesFoundList,
              isSearchStringEmpty: state.isSearchStringEmpty,
              isSearchQueryInProgress: state.isSearchInProgress,
              onPlacesFoundItemPressed: (place) => bloc.add(
                AddToSearchHistory(place),
              ),
              onDeleteHistorySearchItemPressed: (place) => bloc.add(
                RemoveFromSearchHistory(place),
              ),
              onClearHistoryPressed: () => bloc.add(
                ClearSearchHistory(),
              ),
              onHistorySearchItemPressed: _fillSearchField,
            );
          },
        ),
      ],
    );
  }
}
