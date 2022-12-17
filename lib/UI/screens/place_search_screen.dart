import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/UI/screens/components/custom_divider.dart';
import 'package:places/UI/screens/components/custom_icon_button.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/UI/screens/components/label_field_text.dart';
import 'package:places/UI/screens/components/rounded_cached_network_image.dart';
import 'package:places/UI/screens/components/search_bar.dart';
import 'package:places/UI/screens/place_details_screen.dart';
import 'package:places/data/interactor/place_search_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/providers/interactor_provider.dart';
import 'package:provider/provider.dart';

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
        titleTextStyle: theme.textTheme.subtitle1?.copyWith(
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

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedPlaceSearchBodyState extends InheritedWidget {
  final _PlaceSearchBodyState data;

  const _InheritedPlaceSearchBodyState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedPlaceSearchBodyState old) {
    return true;
  }

  static _PlaceSearchBodyState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            _InheritedPlaceSearchBodyState>() as _InheritedPlaceSearchBodyState)
        .data;
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
  late final PlaceSearchInteractor _placeSearchInteractor =
      context.read<InteractorProvider>().placeSearchInteractor;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  /// Найденные места.
  late List<Place> _placesFoundList = [];

  /// Флаг начала процесса поиска мест.
  bool _searchInProgress = false;

  /// Данные строки поиска.
  String _searchString = '';

  @override
  Widget build(BuildContext context) {
    return _InheritedPlaceSearchBodyState(
      data: this,
      child: Column(
        children: const [
          _SearchBar(),
          _SearchResults(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _initializeFiltersAndUserCoordinates();

    // Активировать поле при открытии экрана.
    _searchFocusNode.requestFocus();

    _addListenerToUpdatePlacesFoundList();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
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
    _searchController.addListener(() {
      _searchString = _searchController.text.trim();
      if (_searchString.isNotEmpty) {
        setState(() {
          _searchInProgress = true;
        });

        _applyAllFilters(_searchString).then((value) => setState(() {
              _searchInProgress = false;
            }));
      } else {
        setState(() {});
      }
    });
  }

  /// Очищает поле поиска
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
  void _fillSearchFieldWithItem(String itemName) {
    _searchController.text = itemName;

    setState(() {});
  }

  /// Применяет фильтрацию по всем текущим параметрам.
  Future<void> _applyAllFilters(String searchString) async {
    _placesFoundList =
        await _placeSearchInteractor.getFilteredPlaces(searchString);
  }
}

/// Поле ввода для поиска мест.
class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dataStorage = _InheritedPlaceSearchBodyState.of(context);
    final searchController = dataStorage._searchController;
    final searchFocusNode = dataStorage._searchFocusNode;

    return SearchBar(
      controller: searchController,
      focusNode: searchFocusNode,
      suffixIcon: IconButton(
        icon: const Icon(Icons.cancel),
        color: theme.primaryColorDark,
        onPressed: dataStorage._clearSearchText,
      ),
    );
  }
}

/// Отображает результаты поиска: историю прошлых поисков или найденные места,
/// если в строке поиска начат ввод текста.
class _SearchResults extends StatelessWidget {
  const _SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedPlaceSearchBodyState.of(context);
    final searchInProgress = dataStorage._searchInProgress;

    return !searchInProgress
        ? Expanded(
            flex: 10,
            child: Column(
              children: const [
                _SearchHistory(),
                _PlacesFoundList(),
              ],
            ),
          )
        : const CircularProgressIndicator();
  }
}

/// Отображает историю поиска.
class _SearchHistory extends StatelessWidget {
  const _SearchHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedPlaceSearchBodyState.of(context);
    final searchHistory = dataStorage._placeSearchInteractor.searchHistory;
    final isSearchInProgress = dataStorage._searchString.isNotEmpty;

    // Не показывать историю поиска, если она пуста, или если начат поиск мест.
    return searchHistory.isEmpty || isSearchInProgress
        ? const SizedBox.shrink()
        : const _SearchHistoryList();
  }
}

/// Список истории поиска.
///
/// Содержит элементы истории поиска, кнопку очистки истории поиска.
class _SearchHistoryList extends StatelessWidget {
  const _SearchHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _SearchedByYouLabel(),
          _SearchHistoryItems(),
        ],
      ),
    );
  }
}

/// Заголовок "вы искали".
class _SearchedByYouLabel extends StatelessWidget {
  const _SearchedByYouLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LabelFieldText(
      AppStrings.searchedByYou,
      padding: EdgeInsets.only(
        left: 16,
        top: 32,
        bottom: 19,
      ),
    );
  }
}

/// Элементы истории поиска.
class _SearchHistoryItems extends StatelessWidget {
  const _SearchHistoryItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedPlaceSearchBodyState.of(context);
    final searchHistory = dataStorage._placeSearchInteractor.searchHistory;
    List<Widget> listOfItems;
    listOfItems = searchHistory
        .map((place) => _SearchItem(
              place: place,
            ))
        .cast<Widget>()
        .toList()
      ..add(
        const _ClearSearchHistoryButton(), // Кнопка очистки истории в конце списка.
      );

    final itemCount = listOfItems.length;

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return listOfItems[index];
        },
        separatorBuilder: (context, index) {
          // Не отрисовывать разделитель для последнего элемента.
          return (index != itemCount - 2)
              ? const _SearchHistoryItemDivider()
              : const SizedBox.shrink();
        },
      ),
    );
  }
}

/// Элемент истории поиска.
///
/// Содержит имя искомого ранее места.
/// Позволяет удалить элемент из списка истории поиска.
class _SearchItem extends StatelessWidget {
  final Place place;

  const _SearchItem({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8.0,
      ),
      child: Row(
        children: [
          _HistorySearchItemTextButton(
            place: place,
          ),
          const Spacer(),
          _DeleteHistorySearchItemFromListButton(
            place: place,
          ),
        ],
      ),
    );
  }
}

/// Кнопка удаления элемента истории поиска из списка.
class _DeleteHistorySearchItemFromListButton extends StatelessWidget {
  final Place place;

  const _DeleteHistorySearchItemFromListButton({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomIconButton(
      onPressed: () => _InheritedPlaceSearchBodyState.of(context)
          ._deleteFromSearchHistory(place),
      icon: Icons.close,
      color: secondaryColor.withOpacity(0.56),
    );
  }
}

/// Кнопка очищения истории поиска.
class _ClearSearchHistoryButton extends StatelessWidget {
  const _ClearSearchHistoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dataStorage = _InheritedPlaceSearchBodyState.of(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: CustomTextButton(
        AppStrings.clearHistory,
        textStyle: theme.textTheme.button?.copyWith(
          color: theme.colorScheme.primary,
        ),
        padding: const EdgeInsets.only(
          top: 28,
        ),
        onPressed: dataStorage._deleteAllItemsFromSet,
      ),
    );
  }
}

/// Текстовая кнопка элемента истории поиска.
///
/// При нажатии заполняется поле поиска места.
class _HistorySearchItemTextButton extends StatelessWidget {
  final Place place;

  const _HistorySearchItemTextButton({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomTextButton(
      place.name,
      textStyle: theme.textTheme.bodyText1?.copyWith(
        color: secondaryColor,
      ),
      alignment: Alignment.centerLeft,
      onPressed: () => _fillSearchFieldWithItem(context),
    );
  }

  /// Заполняет поле поиска заданным элементом.
  void _fillSearchFieldWithItem(BuildContext context) {
    _InheritedPlaceSearchBodyState.of(context)
        ._fillSearchFieldWithItem(place.name);
  }
}

/// Разделитель между элементами истории поиска.
class _SearchHistoryItemDivider extends StatelessWidget {
  const _SearchHistoryItemDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomDivider(
      color: secondaryColor.withOpacity(0.2),
      thickness: 0.8,
      padding: const EdgeInsets.only(
        top: 13,
        bottom: 15,
      ),
    );
  }
}

/// Список найденных мест.
class _PlacesFoundList extends StatelessWidget {
  const _PlacesFoundList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedPlaceSearchBodyState.of(context);
    final placesFoundList = dataStorage._placesFoundList;
    final isSearchInProgress = dataStorage._searchString.isNotEmpty;

    // Не показывать список найденных мест, если ещё не начат их поиск.
    return !isSearchInProgress
        ? const SizedBox.shrink()

        // Отобразить список найденных мест, если они были найдены.
        : placesFoundList.isNotEmpty
            ? Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 43,
                  ),
                  children: placesFoundList.map((placeFoundItem) {
                    final isLastItem = placesFoundList.last == placeFoundItem;

                    return _PlacesFoundItem(
                      place: placeFoundItem,
                      isLastItem: isLastItem,
                    );
                  }).toList(),
                ),
              )
            // Отобразить информацию, что места не найдены.
            : const _PlacesNotFoundInfo();
  }
}

/// Найденное место.
class _PlacesFoundItem extends StatelessWidget {
  final Place place;
  final bool isLastItem;

  const _PlacesFoundItem({
    Key? key,
    required this.place,
    this.isLastItem = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPlacesDetailsBottomSheet(context, place),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _PlaceFoundImage(
              place: place,
            ),
          ),
          Expanded(
            flex: 5,
            child: _PlaceFoundDetails(
              place: place,
              isLastItem: isLastItem,
            ),
          ),
        ],
      ),
    );
  }

  /// Сохранение места в истории поиска и открытие боттомшита детализации места.
  void _showPlacesDetailsBottomSheet(BuildContext context, Place place) {
    // Сохранить переход в истории поиска.
    final dataStorage = _InheritedPlaceSearchBodyState.of(context);
    dataStorage._placeSearchInteractor.addToSearchHistory(place);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PlaceDetailsScreen(place.id ?? 0),
    );
  }
}

/// Картинка найденного места
class _PlaceFoundImage extends StatelessWidget {
  /// Картинка по умолчанию.
  static const defaultImageUrl =
      'https://wallbox.ru/resize/1024x768/wallpapers/main2/201726/pole12.jpg';

  final Place place;

  const _PlaceFoundImage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedCachedNetworkImage(
      size: 56,
      borderRadius: BorderRadius.circular(12),
      url: place.photoUrlList?[0] ?? defaultImageUrl,
    );
  }
}

/// Детали найденного места.
class _PlaceFoundDetails extends StatelessWidget {
  final Place place;
  final bool isLastItem;

  const _PlaceFoundDetails({
    Key? key,
    required this.place,
    required this.isLastItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedPlaceSearchBodyState.of(context);
    final searchString = dataStorage._searchString;

    final theme = Theme.of(context);
    final placeNameTextStyle = theme.textTheme.bodyText1?.copyWith(
      color: theme.primaryColorDark,
    );
    final highlightedPlaceNameTextStyle = placeNameTextStyle!.copyWith(
      fontWeight: FontWeight.bold,
    );
    final placeTypeTextStyle = theme.textTheme.bodyText2?.copyWith(
      color: theme.colorScheme.secondary,
    );

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: highlightOccurrences(
                place.name,
                searchString,
                highlightStyle: highlightedPlaceNameTextStyle,
              ),
              style: placeNameTextStyle,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            place.type.toString(),
            style: placeTypeTextStyle,
          ),
          // Не отрисовывать разделитель для последнего элемента списка.
          if (isLastItem) const SizedBox() else const _PlaceFoundItemDivider(),
        ],
      ),
    );
  }

  /// Делает выделение текста [query] в строке [source] заданным стилем [highlightStyle].
  List<TextSpan> highlightOccurrences(
    String source,
    String query, {
    required TextStyle highlightStyle,
  }) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    var lastMatchEnd = 0;

    final children = <TextSpan>[];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: highlightStyle,
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }

    return children;
  }
}

/// Разделитель между найденными местами.
class _PlaceFoundItemDivider extends StatelessWidget {
  const _PlaceFoundItemDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomDivider(
      color: secondaryColor.withOpacity(0.2),
      thickness: 0.8,
      height: 2,
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}

/// Информация о том, что места не найдены.
class _PlacesNotFoundInfo extends StatelessWidget {
  const _PlacesNotFoundInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary.withOpacity(0.56);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.search,
            width: 64,
            height: 64,
            color: secondaryColor,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            AppStrings.nothingFound,
            style: theme.textTheme.subtitle1?.copyWith(
              color: secondaryColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            AppStrings.searchAdvice,
            style: theme.textTheme.bodyText2?.copyWith(
              color: secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
