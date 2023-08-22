import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_app_bar.dart';
import 'package:places/core/presentation/widgets/search_bar.dart'
    as custom_search_bar;
import 'package:places/features/place_list/presentation/widgets/sliver_app_bar/components/filter_button.dart';

/// Кастомный аппбар на сливере.
class SliverAppBar extends StatelessWidget {
  const SliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverPersistentHeader(
      pinned: true,
      delegate: _CustomAppBarDelegate(expandedHeight: 245),
    );
  }
}

/// Делегат кастомного аппбара.
///
/// По умолчанию аппбар состоит из крупного заголовка и строки поиска мест.
/// При сужении аппбара строка поиска мест становится невидимой, заголовок аппбара уменьшается.
class _CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 150;

  const _CustomAppBarDelegate({
    required this.expandedHeight,
  });

  /// Открывает экран поиска мест.
  Future<void> _navigateToPlaceSearchScreen(BuildContext context) async {
    await Navigator.pushNamed<void>(
      context,
      AppRouter.placeSearch,
    );
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Вычисление значений параметров аппбара в зависимости от того, начал ли аппбар сужаться.
    final isScrollStarted = shrinkOffset > 0;
    final theme = Theme.of(context);
    final title = isScrollStarted
        ? AppStrings.placeListAppBarTitle
        : AppStrings.placeListAppBarTitleWithLineBreak;
    final titleTextStyle = isScrollStarted
        ? theme.textTheme.titleMedium
        : theme.textTheme.headlineMedium;
    final centerTitle = isScrollStarted;

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: CustomAppBar(
            title: title,
            titleTextStyle: titleTextStyle,
            centerTitle: centerTitle,
            toolbarHeight: 128,
            padding: EdgeInsets.only(
              // При сужении аппбара убираются отступы у аппбара.
              top: isScrollStarted ? 0 : 40,
              bottom: isScrollStarted ? 0 : 16,
            ),
          ),
        ),
        Expanded(
          child: Opacity(
            // При сужении аппбара строка поиска становится невидимой.
            opacity: 1 - shrinkOffset / expandedHeight,
            child: custom_search_bar.SearchBar(
              readOnly: true,
              // Не обрабатывать нажатия, когда строка поиска уже скрыта.
              onTap: isScrollStarted
                  ? null
                  : () => _navigateToPlaceSearchScreen(context),
              suffixIcon: FilterButton(
                isButtonDisabled: isScrollStarted,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
