import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/components/custom_app_bar.dart';
import 'package:places/ui/screen/sight_card.dart';

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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: const [
              _VisitingTabBar(),
              Expanded(
                child: TabBarView(children: [
                  _VisitingList(),
                  _VisitingList(
                    visited: true,
                  ),
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
        labelStyle: AppTypography.roboto14Regular.copyWith(
          color: AppColors.white,
        ),
        unselectedLabelColor: AppColors.waterlooInactive,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(40), // Creates border
          color: AppColors.oxfordBlue,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
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

/// Список посещенных/планируемых к посещению мест.
///
/// Если список пуст, будет отображена соответствующая информация.
///
/// Имеет признак [visited] - место посещено.
class _VisitingList extends StatelessWidget {
  final bool visited;

  const _VisitingList({
    Key? key,
    this.visited = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mocks
            .where(
              (element) => visited ? element.visited : !element.visited,
            )
            .isEmpty
        ? _EmptyVisitingList(showEmptyVisited: visited)
        : SingleChildScrollView(
            child: Column(
              children: mocks
                  .where(
                    (element) => visited ? element.visited : !element.visited,
                  )
                  .map((sight) => SightCard(
                        sight,
                        showDetails: false,
                        enableToFavouritesButton: false,
                        enableRemoveFromFavouritesButton: true,
                        enableCalendarButton: !visited,
                        enableShareButton: visited,
                      ))
                  .toList(),
            ),
          );
  }
}

/// Отображает информацию о пустом списке мест.
///
/// Имеет параметры:
/// * [showEmptyVisited] - признак отображения списка посещенных мест.
class _EmptyVisitingList extends StatelessWidget {
  final bool showEmptyVisited;

  const _EmptyVisitingList({
    Key? key,
    this.showEmptyVisited = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Здесь будет картинка либо для понравившихся мест, либо для посещенных мест.
        Container(
          width: 64,
          height: 64,
          color: AppColors.waterlooInactive,
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
          showEmptyVisited
              ? AppStrings.infoFinishRoute
              : AppStrings.infoMarkLikedPlaces,
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
