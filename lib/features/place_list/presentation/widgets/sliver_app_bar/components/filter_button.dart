import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/stores/place_list_store/place_list_store_base.dart';
import 'package:provider/provider.dart';

/// Кнопка фильтрации достопримечательностей.
///
/// Открывает экран фильтрации, после закрытия которого применяются выбранные фильтры и обновляется текущий экран.
class FilterButton extends StatelessWidget {
  final bool isButtonDisabled;

  const FilterButton({
    Key? key,
    this.isButtonDisabled = false,
  }) : super(key: key);

  /// Открывает экран фильтрации мест.
  ///
  /// После выбора фильтров сохраняет их в стейте текущего экрана и затем применяет их.
  Future<void> _navigateToFiltersScreen(BuildContext context) async {
    final store = context.read<PlaceListStore>();

    final selectedFilters = await Navigator.pushNamed<Map<String, Object>>(
      context,
      AppRouter.placeFilters,
      arguments: {
        'placeTypeFilters': store.placeTypeFilters,
        'radius': store.radius,
      },
    );

    if (selectedFilters != null) {
      final placeTypeFilters =
      selectedFilters['placeTypeFilters'] as Set<PlaceTypes>;
      final radius = selectedFilters['radius'] as double;

      store.saveFilters(placeTypeFilters, radius);
      await store.getFilteredPlaces();
    }
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