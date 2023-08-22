import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_router.dart';

/// Кнопка фильтрации достопримечательностей.
///
/// Открывает экран фильтрации, после закрытия которого применяются выбранные фильтры и обновляется текущий экран.
class FilterButton extends StatelessWidget {
  final bool isButtonDisabled;

  const FilterButton({
    super.key,
    this.isButtonDisabled = false,
  });

  /// Открывает экран фильтрации мест.
  Future<void> _navigateToFiltersScreen(BuildContext context) async {
    await Navigator.pushNamed<void>(
      context,
      AppRouter.placeFilters,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      icon: SvgPicture.asset(
        AppAssets.filter,
        fit: BoxFit.none,
        colorFilter: ColorFilter.mode(
          theme.colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
      color: theme.primaryColorDark,
      onPressed:
          isButtonDisabled ? null : () => _navigateToFiltersScreen(context),
    );
  }
}
