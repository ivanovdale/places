import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/components/custom_app_bar.dart';
import 'package:places/ui/screen/components/custom_bottom_navigation_bar.dart';
import 'package:places/ui/screen/sight_card.dart';

/// Виджет для отображения списка посещенных/планируемых к посещению мест.
///
/// Имеет TabBar для переключения между списками.
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.visitingScreenAppBarTitle,
          titleTextStyle: AppTypography.roboto18RegularSubtitle.copyWith(
            color: AppColors.martinique,
          ),
          centerTitle: true,
          toolbarHeight: 56.0,
          padding: const EdgeInsets.only(
            top: 24.0,
          ),
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
                child: TabBarView(children: [
                  _ToVisitSightList(mocks
                      .where(
                        (element) => !element.visited,
                      )
                      .toList()),
                  _VisitedSightList(mocks
                      .where(
                        (element) => element.visited,
                      )
                      .toList()),
                ]),
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
    return Container(
      height: 40,
      margin: const EdgeInsets.only(
        top: 6.0,
        bottom: 30.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.wildSand,
        borderRadius: BorderRadius.circular(40),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(40), // Creates border
          color: AppColors.oxfordBlue,
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
/// * [showVisitedSights] - признак отображения посещенных/планируемых к посещению мест. True - для посещенных, False - для планируемых.
/// * [emptyVisitingList] - виджет для отображения пустого списка.
///
/// Имеет параметры
/// * [listOfSights] - список достопримечательностей.
abstract class _BaseVisitingSightList extends StatelessWidget {
  abstract final bool showVisitedSights;
  abstract final Widget emptyVisitingList;
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
              children: listOfSights
                  .map((sight) => showVisitedSights
                      ? VisitedSightCard(
                          sight,
                        )
                      : ToVisitSightCard(
                          sight,
                        ))
                  .toList(),
            ),
          );
  }
}

/// Список планируемых к посещению мест. Наследуется от [_BaseVisitingSightList].
///
/// Если список пуст, будет отображена соответствующая информация ([_EmptyToVisitSightList]).
///
/// Переопределяет поля:
/// * [showVisitedSights] - отображать планируемые к посещению;
/// * [emptyVisitingList] - виджет для отображения пустого списка.
class _ToVisitSightList extends _BaseVisitingSightList {
  @override
  late final _BaseEmptyVisitingList emptyVisitingList;

  @override
  bool get showVisitedSights => false;

  _ToVisitSightList(
    List<Sight> listOfSights, {
    Key? key,
  }) : super(listOfSights, key: key) {
    emptyVisitingList = const _EmptyToVisitSightList();
  }
}

/// Список посещенных мест. Наследуется от [_BaseVisitingSightList].
///
/// Если список пуст, будет отображена соответствующая информация ([_EmptyVisitedSightList]).
///
/// Переопределяет поля:
/// * [showVisitedSights] - отображать посещенные;
/// * [emptyVisitingList] - виджет для отображения пустого списка.
class _VisitedSightList extends _BaseVisitingSightList {
  @override
  late final _BaseEmptyVisitingList emptyVisitingList;

  @override
  bool get showVisitedSights => true;

  _VisitedSightList(
    List<Sight> listOfSights, {
    Key? key,
  }) : super(listOfSights, key: key) {
    emptyVisitingList = const _EmptyVisitedSightList();
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
          style: AppTypography.roboto18RegularSubtitle
              .copyWith(color: AppColors.waterlooInactive),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          emptyInfo,
          style: AppTypography.roboto14Regular.copyWith(
            color: AppColors.waterlooInactive,
            fontWeight: FontWeight.w400,
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
  String get emptyIconPath => AppAssets.route;

  @override
  String get emptyInfo => AppStrings.infoFinishRoute;

  const _EmptyVisitedSightList({
    Key? key,
  }) : super(key: key);
}
