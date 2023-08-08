import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/features/place_list/presentation/bloc/place_list_bloc.dart';
import 'package:provider/provider.dart';

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
  ///
  /// После выбора фильтров применяет их на текущем экране.
  Future<void> _navigateToFiltersScreen(BuildContext context) async {
    final bloc = context.read<PlaceListBloc>();
    final state = bloc.state;

    final selectedFilters = await Navigator.pushNamed<Map<String, Object>>(
      context,
      AppRouter.placeFilters,
      arguments: {
        'placeTypeFilters': state.placeTypeFilters,
        'radius': state.radius,
      },
    );

    if (selectedFilters != null) {
      final placeTypeFilters =
          selectedFilters['placeTypeFilters']! as Set<PlaceTypes>;
      final radius = selectedFilters['radius']! as double;

      bloc.add(
        PlaceListWithFiltersLoaded(
          placeTypeFilters: placeTypeFilters,
          radius: radius,
        ),
      );
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
