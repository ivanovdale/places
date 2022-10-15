import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/sight_card.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/ui/screens/components/custom_app_bar.dart';
import 'package:places/ui/screens/components/custom_bottom_navigation_bar.dart';

/// Виджет для отображения списка посещенных/планируемых к посещению мест.
///
/// Имеет TabBar для переключения между списками.
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

/// Состояние экрана списка посещенных/планируемых к посещению мест.
///
/// Хранит список посещённых/планируемых к посещению мест.
class _VisitingScreenState extends State<VisitingScreen> {
  late final List<Sight> toVisitSights;
  late final List<Sight> visitedSights;

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
                child: _InheritedVisitingScreenState(
                  data: this,
                  child: TabBarView(children: [
                    _ToVisitSightList(toVisitSights),
                    _VisitedSightList(visitedSights),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    toVisitSights = mocked.sights
        .where(
          (element) => !element.visited,
        )
        .toList();

    visitedSights = mocked.sights
        .where(
          (element) => element.visited,
        )
        .toList();
  }

  /// Удаляет достопримечательность из списка планируемых к посещению.
  void deleteSightFromToVisitList(Sight sight) {
    setState(() {
      toVisitSights.remove(sight);
    });
  }

  /// Удаляет достопримечательность из списка посещенных.
  void deleteSightFromVisitedList(Sight sight) {
    setState(() {
      visitedSights.remove(sight);
    });
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedVisitingScreenState extends InheritedWidget {
  final _VisitingScreenState data;

  const _InheritedVisitingScreenState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedVisitingScreenState old) {
    return true;
  }

  static _VisitingScreenState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            _InheritedVisitingScreenState>() as _InheritedVisitingScreenState)
        .data;
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
/// * [listOfSightCards] - список достопримечательностей (посещенных/планируемых к посещению);
/// * [emptyVisitingList] - виджет для отображения пустого списка.
///
/// Имеет параметры
/// * [listOfSights] - список достопримечательностей.
abstract class _BaseVisitingSightList extends StatelessWidget {
  abstract final _BaseEmptyVisitingList emptyVisitingList;
  abstract final List<Widget> listOfSightCards;

  final List<Sight> listOfSights;

  const _BaseVisitingSightList(
    this.listOfSights, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listOfSights.isEmpty
        ? emptyVisitingList
        : SingleChildScrollView(
            child: Column(
              children: listOfSightCards,
            ),
          );
  }

  /// Удаляет достопримечательность из списка.
  void deleteSightFromList(Sight sight, BuildContext context);
}

/// Список планируемых к посещению мест. Наследуется от [_BaseVisitingSightList].
///
/// Если список пуст, будет отображена соответствующая информация ([_EmptyToVisitSightList]).
///
/// Переопределяет поля:
/// * [listOfSightCards] - список достопримечательностей (планируемых к посещению);
/// * [emptyVisitingList] - виджет для отображения пустого списка.
///
/// Имеет параметры
/// * [listOfSights] - список достопримечательностей.
class _ToVisitSightList extends _BaseVisitingSightList {
  @override
  late final _BaseEmptyVisitingList emptyVisitingList;

  @override
  late final List<Widget> listOfSightCards;

  _ToVisitSightList(
    List<Sight> listOfSights, {
    Key? key,
  }) : super(listOfSights, key: key) {
    emptyVisitingList = const _EmptyToVisitSightList();
    listOfSightCards = listOfSights.map((sight) {
      return Builder(builder: (context) {
        return ToVisitSightCard(
          sight,
          onDeletePressed: () => deleteSightFromList(sight, context),
        );
      });
    }).toList();
  }

  @override
  void deleteSightFromList(Sight sight, BuildContext context) {
    _InheritedVisitingScreenState.of(context).deleteSightFromToVisitList(sight);
  }
}

/// Список посещенных мест. Наследуется от [_BaseVisitingSightList].
///
/// Если список пуст, будет отображена соответствующая информация ([_EmptyVisitedSightList]).
///
/// Переопределяет поля:
/// * [listOfSightCards] - список достопримечательностей (посещённых);
/// * [emptyVisitingList] - виджет для отображения пустого списка.
///
/// Имеет параметры
/// * [listOfSights] - список достопримечательностей.
class _VisitedSightList extends _BaseVisitingSightList {
  @override
  late final _BaseEmptyVisitingList emptyVisitingList;

  @override
  late final List<Widget> listOfSightCards;

  _VisitedSightList(
    List<Sight> listOfSights, {
    Key? key,
  }) : super(listOfSights, key: key) {
    emptyVisitingList = const _EmptyVisitedSightList();
    listOfSightCards = listOfSights.map((sight) {
      return Builder(builder: (context) {
        return VisitedSightCard(
          sight,
          onDeletePressed: () => deleteSightFromList(sight, context),
        );
      });
    }).toList();
  }

  @override
  void deleteSightFromList(Sight sight, BuildContext context) {
    _InheritedVisitingScreenState.of(context).deleteSightFromVisitedList(sight);
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
