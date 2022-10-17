import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/sight_card.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:places/ui/screens/components/custom_app_bar.dart';
import 'package:places/ui/screens/components/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

/// Виджет для отображения списка посещенных/планируемых к посещению мест.
///
/// Имеет TabBar для переключения между списками.
class VisitingSightsScreen extends StatelessWidget {
  const VisitingSightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.visitingScreenAppBarTitle,
          titleTextStyle: Theme.of(context).textTheme.subtitle1,
          centerTitle: true,
          toolbarHeight: 56.0,
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              const _VisitingTabBar(),
              Expanded(
                child: Consumer<VisitingProvider>(
                  builder: (context, viewModel, child) =>
                      TabBarView(children: [
                    _ToVisitSightList(viewModel),
                    _VisitedSightList(viewModel),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// TabBar для списка посещенных/планируемых к посещению мест.
class _VisitingTabBar extends StatelessWidget {
  const _VisitingTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 40,
      margin: const EdgeInsets.only(
        top: 6.0,
        bottom: 30.0,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(40),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: theme.primaryColor,
        ),
        indicatorWeight: 0.0,
        tabs: const [
          Tab(
            text: AppStrings.wantToVisit,
          ),
          Tab(
            text: AppStrings.visited,
          ),
        ],
      ),
    );
  }
}

/// Абстрактный класс [_BaseVisitingSightList]. Список посещенных/планируемых к посещению мест.
///
/// Если список пуст, будет отображена соответствующая информация ([_BaseEmptyVisitingList]).
///
/// Имеет поля, которые необходимо переопределить в потомках:
/// * [emptyVisitingList] - виджет для отображения пустого списка.
/// * [sightCardType] - тип карточки достопримечательности.
///
/// Имеет параметры
/// * [listOfSights] - список достопримечательностей.
/// * [viewModel] - вьюмодель для работы со списком мест.
abstract class _BaseVisitingSightList extends StatefulWidget {
  final List<Sight> listOfSights;
  abstract final _BaseEmptyVisitingList emptyVisitingList;
  abstract final Type sightCardType;
  final VisitingProvider viewModel;

  const _BaseVisitingSightList({
    Key? key,
    required this.listOfSights,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<_BaseVisitingSightList> createState() => _BaseVisitingSightListState();

  /// Удаляет достопримечательность из списка.
  void deleteSightFromList(Sight sight, BuildContext context);

  /// Вставляет нужную карточку места по заданному индексу.
  void insertIntoSightList(
    int destinationIndex,
    int sightIndex,
    BuildContext context,
  );
}

/// Состояние списка мест.
///
/// Содержит в себе скроллконтроллер для прокрутки списка в момент перетаскивания места.
class _BaseVisitingSightListState extends State<_BaseVisitingSightList> {
  final ScrollController _scrollController = ScrollController();
  bool isDragged = false;

  @override
  Widget build(BuildContext context) {
    return widget.listOfSights.isEmpty
        ? widget.emptyVisitingList
        : SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                for (var index = 0; index < widget.listOfSights.length; index++)
                  Builder(builder: (context) {
                    final sightCard =
                        getSightCard(widget.listOfSights[index], context);

                    return DragTarget<int>(
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        widget.insertIntoSightList(index, data, context);
                      },
                      builder: (
                        context,
                        candidateData,
                        rejectedData,
                      ) {
                        return Listener(
                          // Возможность скроллинга в момент перетаскивания карточки.
                          onPointerMove: isDragged
                              ? scrollSightCardsWhenCardDragged
                              : null,
                          child: _DraggableSightCard(
                            sightCard: sightCard,
                            index: index,
                            candidateData: candidateData,
                            onDragStarted: () => isDragged = true,
                            onDragEnd: (details) => isDragged = false,
                          ),
                        );
                      },
                    );
                  }),
              ],
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  /// Возвращает карточку места в зависимости от типа поля sightCardType.
  BaseSightCard getSightCard(Sight sight, BuildContext context) {
    return widget.sightCardType == ToVisitSightCard
        ? ToVisitSightCard(
            sight,
            key: GlobalKey(),
            onDeletePressed: () => widget.deleteSightFromList(sight, context),
          )
        : VisitedSightCard(
            sight,
            key: GlobalKey(),
            onDeletePressed: () => widget.deleteSightFromList(sight, context),
          );
  }

  /// Делает скролл вверх или вниз в зависимости от того, в какую область перетаскивается карточка места.
  void scrollSightCardsWhenCardDragged(PointerMoveEvent event) {
    const scrollArea = 300;

    if (event.position.dy > MediaQuery.of(context).size.height - scrollArea) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );

      /// Скролл вверх при перетаскивании.
    } else if (event.position.dy < scrollArea) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }
}

/// Карточка места с возможностью перетаскивания.
class _DraggableSightCard extends StatelessWidget {
  final VoidCallback? onDragStarted;
  final Function(DraggableDetails)? onDragEnd;
  final BaseSightCard sightCard;
  final int index;
  final List<int?> candidateData;

  const _DraggableSightCard({
    Key? key,
    this.onDragStarted,
    this.onDragEnd,
    required this.sightCard,
    required this.index,
    required this.candidateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: index,
      child: _SightCardWithHoverAbility(
        sightCard: sightCard,
        candidateData: candidateData,
      ),
      childWhenDragging: const SizedBox(
        height: 50,
      ),
      onDragStarted: onDragStarted,
      onDragEnd: onDragEnd,
      feedback: _SightCardWhenDragged(sightCard: sightCard),
    );
  }
}

/// Карточка места с подсветкой в момент, когда над ней происходит перетаскивание другой карточки.
/// Идентифицирует о возможности сделать дроп в эту область.
class _SightCardWithHoverAbility extends StatelessWidget {
  final BaseSightCard sightCard;
  final List<int?> candidateData;

  const _SightCardWithHoverAbility({
    Key? key,
    required this.sightCard,
    required this.candidateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          if (candidateData.isNotEmpty)
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              blurRadius: 2,
              spreadRadius: 0.5,
              offset: const Offset(0, -7),
              blurStyle: BlurStyle.inner,
            )
          else
            const BoxShadow(color: Colors.transparent),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: sightCard,
    );
  }
}

/// Карточка места в момент перетаскивания.
class _SightCardWhenDragged extends StatelessWidget {
  final BaseSightCard sightCard;

  const _SightCardWhenDragged({
    Key? key,
    required this.sightCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      height: 254,
      child: sightCard,
    );
  }
}

/// Список планируемых к посещению мест. Наследуется от [_BaseVisitingSightList].
///
/// Если список пуст, будет отображена соответствующая информация ([_EmptyToVisitSightList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [sightCardType] - тип карточки достопримечательности.
///
/// Имеет параметры
/// * [listOfSights] - список достопримечательностей.
class _ToVisitSightList extends _BaseVisitingSightList {
  @override
  late final _BaseEmptyVisitingList emptyVisitingList;

  @override
  late final Type sightCardType;

  _ToVisitSightList(
    VisitingProvider viewModel, {
    Key? key,
  }) : super(
          listOfSights: viewModel.toVisitSights,
          viewModel: viewModel,
          key: key,
        ) {
    emptyVisitingList = const _EmptyToVisitSightList();
    sightCardType = ToVisitSightCard;
  }

  @override
  void deleteSightFromList(Sight sight, BuildContext context) {
    viewModel.deleteSightFromToVisitList(sight);
  }

  @override
  void insertIntoSightList(
    int destinationIndex,
    int sightIndex,
    BuildContext context,
  ) {
    viewModel.insertIntoToVisitSightList(destinationIndex, sightIndex);
  }
}

/// Список посещенных мест. Наследуется от [_BaseVisitingSightList].
///
/// Если список пуст, будет отображена соответствующая информация ([_EmptyVisitedSightList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [sightCardType] - тип карточки достопримечательности.
///
/// Имеет параметры
/// * [listOfSights] - список достопримечательностей.
class _VisitedSightList extends _BaseVisitingSightList {
  @override
  late final _BaseEmptyVisitingList emptyVisitingList;

  @override
  late final Type sightCardType;

  _VisitedSightList(
    VisitingProvider viewModel, {
    Key? key,
  }) : super(
          listOfSights: viewModel.visitedSights,
          viewModel: viewModel,
          key: key,
        ) {
    emptyVisitingList = const _EmptyVisitedSightList();
    sightCardType = VisitedSightCard;
  }

  @override
  void deleteSightFromList(Sight sight, BuildContext context) {
    viewModel.deleteSightFromVisitedList(sight);
  }

  @override
  void insertIntoSightList(
    int destinationIndex,
    int sightIndex,
    BuildContext context,
  ) {
    viewModel.insertIntoVisitedSightList(destinationIndex, sightIndex);
  }
}

/// Отображает информацию о пустом списке мест.
///
/// Имеет поля, которые необходимо переопределить в потомках:
/// * [emptyInfo] - информация об отсутсвии записей;
/// * [emptyIconPath] - иконка пустого списка.
abstract class _BaseEmptyVisitingList extends StatelessWidget {
  static const double _iconSize = 64.0;

  abstract final String emptyInfo;
  abstract final String emptyIconPath;

  const _BaseEmptyVisitingList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final secondaryColor = theme.colorScheme.secondary.withOpacity(0.56);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          emptyIconPath,
          height: _iconSize,
          width: _iconSize,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          AppStrings.empty,
          style: textTheme.subtitle1?.copyWith(
            color: secondaryColor,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          emptyInfo,
          style: textTheme.bodyText2?.copyWith(
            color: secondaryColor,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Отображает информацию о пустом списке планируемых к посещению мест.
class _EmptyToVisitSightList extends _BaseEmptyVisitingList {
  @override
  String get emptyIconPath => AppAssets.addNewCard;

  @override
  String get emptyInfo => AppStrings.infoMarkLikedPlaces;

  const _EmptyToVisitSightList({
    Key? key,
  }) : super(key: key);
}

/// Отображает информацию о пустом списке посещенных мест.
class _EmptyVisitedSightList extends _BaseEmptyVisitingList {
  @override
  String get emptyIconPath => AppAssets.emptyRoute;

  @override
  String get emptyInfo => AppStrings.infoFinishRoute;

  const _EmptyVisitedSightList({
    Key? key,
  }) : super(key: key);
}
