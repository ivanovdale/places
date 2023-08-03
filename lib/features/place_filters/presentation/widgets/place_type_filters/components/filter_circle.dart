import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/place_filters/presentation/bloc/place_filters_bloc.dart';
import 'package:provider/provider.dart';

/// Круглая картинка категории с пометкой активации фильтра.
class FilterCircle extends StatelessWidget {
  final PlaceTypes placeType;

  const FilterCircle({
    Key? key,
    required this.placeType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PlaceFiltersBloc>();
    final selectedPlaceTypeFilters =
        context.select<PlaceFiltersBloc, Set<PlaceTypes>>(
      (bloc) => bloc.state.selectedPlaceTypeFilters,
    );
    final isFilterSelected = selectedPlaceTypeFilters.contains(placeType);

    final theme = Theme.of(context);
    final colorSchemePrimaryColor = theme.colorScheme.primary;

    return Stack(
      children: [
        Material(
          borderRadius: BorderRadius.circular(50),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: InkWell(
            onTap: () => bloc.add(
              PlaceFiltersTypeFilterSelected(
                placeType: placeType,
              ),
            ),
            child: ClipOval(
              child: Container(
                height: 64,
                width: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorSchemePrimaryColor.withOpacity(0.16),
                ),
                child: SvgPicture.asset(
                  placeType.imagePath,
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                    colorSchemePrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isFilterSelected)
          Positioned(
            right: 1,
            bottom: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: theme.primaryColor,
              ),
              child: Icon(
                Icons.done,
                size: 16,
                color: theme.scaffoldBackgroundColor,
              ),
            ),
          ),
      ],
    );
  }
}
