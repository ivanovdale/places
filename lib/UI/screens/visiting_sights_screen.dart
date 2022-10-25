import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/sight_card.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:places/ui/screens/components/custom_app_bar.dart';
import 'package:places/ui/screens/components/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

/// Экран списка посещенных/планируемых к посещению мест.
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
                  builder: (context, viewModel, child) => TabBarView(children: [
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
    final listOfSights = widget.listOfSights;

    return listOfSights.isEmpty
        ? widget.emptyVisitingList
        : ListView.builder(
            controller: _scrollController,
            itemCount: listOfSights.length,
            itemBuilder: (context, index) {
              final sightCard = getSightCard(
                listOfSights[index],
                context,
              );

              return Stack(
                children: [
                  _BackgroundOnDismiss(
                    isDraggingActive: isDragged,
                  ),
                  Dismissible(
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) => widget.deleteSightFromList(
                      listOfSights[index],
                      context,
                    ),
                    key: ObjectKey(listOfSights[index]),
                    child: _DraggableSightCardWithDragTargetOption(
                      index: index,
                      sightCard: sightCard,
                      isDragged: isDragged,
                      onDragStarted: onDragStarted,
                      onDragEnd: onDragEnd,
                      onAccept: (data) =>
                          widget.insertIntoSightList(index, data, context),
                      scrollSightCardsWhenCardDragged:
                          scrollSightCardsWhenCardDragged,
                    ),
                  ),
                ],
              );
            },
          );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  /// Возвращает карточку места в зависимости от типа поля sightCardType.
  Widget getSightCard(Sight sight, BuildContext context) {
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

  /// Устанавливает состояние - началось перетаскивание элемента.
  void onDragStarted() {
    setState(() {
      isDragged = true;
    });
  }

  /// Устанавливает состояние - завершилось перетаскивание элемента.
  void onDragEnd(DraggableDetails details) {
    if (details.wasAccepted) {
      setState(() {
        isDragged = false;
      });
    }
  }
}

/// Перетаскиваемая карточка места с возможностью перетаскивать на неё другие карточки для сортировки списка мест.
class _DraggableSightCardWithDragTargetOption extends StatelessWidget {
  final int index;
  final Widget sightCard;
  final bool isDragged;
  final VoidCallback? onDragStarted;
  final Function(DraggableDetails) onDragEnd;
  final Function(int)? onAccept;
  final Function(PointerMoveEvent)? scrollSightCardsWhenCardDragged;

  const _DraggableSightCardWithDragTargetOption({
    Key? key,
    required this.index,
    this.onAccept,
    required this.sightCard,
    required this.isDragged,
    this.onDragStarted,
    required this.onDragEnd,
    this.scrollSightCardsWhenCardDragged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onWillAccept: (data) {
        return true;
      },
      onAccept: onAccept,
      builder: (
        context,
        candidateData,
        rejectedData,
      ) {
        return Listener(
          // Возможность скроллинга в момент перетаскивания карточки.
          onPointerMove: isDragged ? scrollSightCardsWhenCardDragged : null,
          child: _DraggableSightCard(
            sightCard: sightCard,
            index: index,
            candidateData: candidateData,
            onDragStarted: onDragStarted,
            onDragEnd: onDragEnd,
          ),
        );
      },
    );
  }
}

/// Карточка места с возможностью перетаскивания.
class _DraggableSightCard extends StatelessWidget {
  final VoidCallback? onDragStarted;
  final Function(DraggableDetails)? onDragEnd;
  final Widget sightCard;
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
  final Widget sightCard;
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
  final Widget sightCard;

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

/// Задний фон, когда происходит свайп карточки влево для удаления.
class _BackgroundOnDismiss extends StatelessWidget {
  final bool isDraggingActive;

  const _BackgroundOnDismiss({
    Key? key,
    required this.isDraggingActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return !isDraggingActive
        ? Container(
            alignment: Alignment.centerRight,
            height: 238,
            width: double.infinity,
            margin: const EdgeInsets.only(
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.flamingo,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.delete,
                  width: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    AppStrings.delete,
                    style: theme.textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
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
