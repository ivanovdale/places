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
import 'package:places/UI/screens/sight_details_screen.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/utils/work_with_places_mixin.dart';

/// Отображает поле поиска достопримечательностей, историю поиска, найденные достопримечательности.
/// Позволяет очистить историю поиска.
/// Позволяет перейти в детальную информацию места.
///
/// Хранит фильтры, которые будут учитываться при поиске мест.
class SightSearchScreen extends StatelessWidget {
  final List<Map<String, Object>> sightTypeFilters;
  final double distanceFrom;
  final double distanceTo;

  const SightSearchScreen({
    Key? key,
    required this.sightTypeFilters,
    required this.distanceFrom,
    required this.distanceTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.sightListAppBarTitle,
        titleTextStyle: theme.textTheme.subtitle1?.copyWith(
          color: theme.primaryColorDark,
        ),
        centerTitle: true,
        toolbarHeight: 56,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: _SightSearchBody(
        sightTypeFilters: sightTypeFilters,
        distanceFrom: distanceFrom,
        distanceTo: distanceTo,
      ),
    );
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedSightSearchBodyState extends InheritedWidget {
  final _SightSearchBodyState data;

  const _InheritedSightSearchBodyState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedSightSearchBodyState old) {
    return true;
  }

  static _SightSearchBodyState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            _InheritedSightSearchBodyState>() as _InheritedSightSearchBodyState)
        .data;
  }
}

/// Отображает историю поиска, найденные достопримечательности.
/// Позволяет очистить историю поиска.
/// Позволяет перейти в детальную информацию места.
class _SightSearchBody extends StatefulWidget {
  final List<Map<String, Object>> sightTypeFilters;
  final double distanceFrom;
  final double distanceTo;

  const _SightSearchBody({
    Key? key,
    required this.sightTypeFilters,
    required this.distanceFrom,
    required this.distanceTo,
  }) : super(key: key);

  @override
  State<_SightSearchBody> createState() => _SightSearchBodyState();
}

/// Хранит состояние поиска мест.
class _SightSearchBodyState extends State<_SightSearchBody>
    with WorkWithPlaces {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  /// История поиска мест.
  final Set<String> _searchHistory = {};

  /// Найденные достопримечательности.
  late List<Sight> _sightsFoundList = [];

  /// Флаг начала процесса поиска мест.
  bool _searchInProgress = false;

  /// Данные строки поиска.
  String _searchString = '';

  @override
  Widget build(BuildContext context) {
    return _InheritedSightSearchBodyState(
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
    // Активировать поле при открытии экрана.
    _searchFocusNode.requestFocus();

    // Обновление найденных мест.
    _searchController.addListener(() {
      _searchString = _searchController.text.trim();
      if (_searchString.isNotEmpty) {
        setState(() {
          _searchInProgress = true;
        });

        // Имитация работы сервера.
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            applyAllFilters(_searchString);
            setState(() {
              _searchInProgress = false;
            });
          },
        );
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
  }

  /// Очищает поле поиска
  void clearSearchText() {
    _searchController.clear();
  }

  /// Удаляет элемент из списка истории поиска по его имени.
  void deleteItemFromSet(String itemName) {
    _searchHistory.removeWhere((searchItem) => searchItem == itemName);
    setState(() {});
  }

  /// Удаляет все элементы из списка истории поиска.
  void deleteAllItemsFromSet() {
    _searchHistory.clear();
    setState(() {});
  }

  /// Заполняет поле поиска переданной строкой.
  void fillSearchFieldWithItem(String itemName) {
    _searchController.text = itemName;
    setState(() {});
  }

  /// Применяет фильтрацию по всем текущим параметрам.
  void applyAllFilters(String searchString) {
    final range = {
      'distanceFrom': widget.distanceFrom,
      'distanceTo': widget.distanceTo,
    };
    // Общая фильтрация по фильтрам.
    final sightsFilteredByTypeAndRadius = getFilteredByTypeAndRadiusSights(
      mocked.sights,
      widget.sightTypeFilters,
      mocked.userCoordinates,
      range,
    );
    // Финальная фильтрация по наименованию.
    _sightsFoundList = getFilteredByNameSights(
      sightsFilteredByTypeAndRadius,
      searchString,
    );
  }
}

/// Поле ввода для поиска достопримечательностей.
class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dataStorage = _InheritedSightSearchBodyState.of(context);
    final searchController = dataStorage._searchController;
    final searchFocusNode = dataStorage._searchFocusNode;

    return SearchBar(
      controller: searchController,
      focusNode: searchFocusNode,
      suffixIcon: IconButton(
        icon: const Icon(Icons.cancel),
        color: theme.primaryColorDark,
        onPressed: dataStorage.clearSearchText,
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
    final dataStorage = _InheritedSightSearchBodyState.of(context);
    final searchInProgress = dataStorage._searchInProgress;

    return !searchInProgress
        ? Expanded(
            flex: 10,
            child: Column(
              children: const [
                _SearchHistory(),
                _SightsFoundList(),
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
    final dataStorage = _InheritedSightSearchBodyState.of(context);
    final searchHistory = dataStorage._searchHistory;
    final isSearchInProgress = dataStorage._searchString.isNotEmpty;

    // Не показывать историю поиска, если она пуста, или если начат поиск достопримечательностей.
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
    final dataStorage = _InheritedSightSearchBodyState.of(context);
    final searchHistory = dataStorage._searchHistory;
    List<Widget> listOfItems;
    listOfItems = searchHistory
        .map((searchString) => _SearchItem(
              itemName: searchString,
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
  final String itemName;

  const _SearchItem({
    Key? key,
    required this.itemName,
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
            itemName: itemName,
          ),
          const Spacer(),
          _DeleteHistorySearchItemFromListButton(
            itemName: itemName,
          ),
        ],
      ),
    );
  }
}

/// Кнопка удаления элемента истории поиска из списка.
class _DeleteHistorySearchItemFromListButton extends StatelessWidget {
  final String itemName;

  const _DeleteHistorySearchItemFromListButton({
    Key? key,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomIconButton(
      onPressed: () => deleteItemFromSet(context),
      icon: Icons.close,
      color: secondaryColor.withOpacity(0.56),
    );
  }

  /// Вызывает функцию из стейта экрана, которая удаляет элемент из списка истории поиска.
  void deleteItemFromSet(BuildContext context) {
    _InheritedSightSearchBodyState.of(context).deleteItemFromSet(itemName);
  }
}

/// Кнопка очищения истории поиска.
class _ClearSearchHistoryButton extends StatelessWidget {
  const _ClearSearchHistoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dataStorage = _InheritedSightSearchBodyState.of(context);

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
        onPressed: dataStorage.deleteAllItemsFromSet,
      ),
    );
  }
}

/// Текстовая кнопка элемента истории поиска.
///
/// При нажатии заполняется поле поиска места.
class _HistorySearchItemTextButton extends StatelessWidget {
  final String itemName;

  const _HistorySearchItemTextButton({
    Key? key,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomTextButton(
      itemName,
      textStyle: theme.textTheme.bodyText1?.copyWith(
        color: secondaryColor,
      ),
      alignment: Alignment.centerLeft,
      onPressed: () => fillSearchFieldWithItem(context),
    );
  }

  /// Заполняет поле поиска заданным элементом.
  void fillSearchFieldWithItem(BuildContext context) {
    _InheritedSightSearchBodyState.of(context)
        .fillSearchFieldWithItem(itemName);
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

/// Список найденных достопримечательностей.
class _SightsFoundList extends StatelessWidget {
  const _SightsFoundList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedSightSearchBodyState.of(context);
    final sightsFoundList = dataStorage._sightsFoundList;
    final isSearchInProgress = dataStorage._searchString.isNotEmpty;

    // Не показывать список найденных достопримечательностей, если ещё не начат их поиск.
    return !isSearchInProgress
        ? const SizedBox.shrink()

        // Отобразить список найденных достопримечательностей, если они были найдены.
        : sightsFoundList.isNotEmpty
            ? Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 43,
                  ),
                  children: sightsFoundList.map((sightFoundItem) {
                    final isLastItem = sightsFoundList.last == sightFoundItem;

                    return _SightsFoundItem(
                      sight: sightFoundItem,
                      isLastItem: isLastItem,
                    );
                  }).toList(),
                ),
              )
            // Отобразить информацию, что достопримечательности не найдены.
            : const _SightsNotFoundInfo();
  }
}

/// Найденная достопримечательность.
class _SightsFoundItem extends StatelessWidget {
  final Sight sight;
  final bool isLastItem;

  const _SightsFoundItem({
    Key? key,
    required this.sight,
    this.isLastItem = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToSightDetailsScreen(context, sight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _SightFoundImage(
              sight: sight,
            ),
          ),
          Expanded(
            flex: 5,
            child: _SightFoundDetails(
              sight: sight,
              isLastItem: isLastItem,
            ),
          ),
        ],
      ),
    );
  }

  /// Переход на экран детализации достопримечательности.
  void navigateToSightDetailsScreen(BuildContext context, Sight sight) {
    // Сохранить переход в истории поиска.
    final dataStorage = _InheritedSightSearchBodyState.of(context);
    dataStorage._searchHistory.add(sight.name);

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => SightDetailsScreen(sight),
      ),
    );
  }
}

/// Картинка найденного места
class _SightFoundImage extends StatelessWidget {
  /// Картинка по умолчанию.
  static const defaultImageUrl =
      'https://wallbox.ru/resize/1024x768/wallpapers/main2/201726/pole12.jpg';

  final Sight sight;

  const _SightFoundImage({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedCachedNetworkImage(
      size: 56,
      borderRadius: BorderRadius.circular(12),
      url: sight.url ?? defaultImageUrl,
    );
  }
}

/// Детали найденного места.
class _SightFoundDetails extends StatelessWidget {
  final Sight sight;
  final bool isLastItem;

  const _SightFoundDetails({
    Key? key,
    required this.sight,
    required this.isLastItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedSightSearchBodyState.of(context);
    final searchString = dataStorage._searchString;

    final theme = Theme.of(context);
    final sightNameTextStyle = theme.textTheme.bodyText1?.copyWith(
      color: theme.primaryColorDark,
    );
    final highlightedSightNameTextStyle = sightNameTextStyle!.copyWith(
      fontWeight: FontWeight.bold,
    );
    final sightTypeTextStyle = theme.textTheme.bodyText2?.copyWith(
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
                sight.name,
                searchString,
                highlightStyle: highlightedSightNameTextStyle,
              ),
              style: sightNameTextStyle,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            sight.type.toString(),
            style: sightTypeTextStyle,
          ),
          // Не отрисовывать разделитель для последнего элемента списка.
          if (isLastItem) const SizedBox() else const _SightFoundItemDivider(),
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
class _SightFoundItemDivider extends StatelessWidget {
  const _SightFoundItemDivider({Key? key}) : super(key: key);

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
class _SightsNotFoundInfo extends StatelessWidget {
  const _SightsNotFoundInfo({Key? key}) : super(key: key);

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
