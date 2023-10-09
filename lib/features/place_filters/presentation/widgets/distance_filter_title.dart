import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/features/place_filters/presentation/bloc/place_filters_bloc.dart';

/// Заголовок фильтра по расстоянию. Отображает расстояние от и до.
class DistanceFilterTitle extends StatelessWidget {
  const DistanceFilterTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final radius = context.select<PlaceFiltersBloc, double>(
      (bloc) => bloc.state.radius,
    );
    final radiusInKilometers = (radius / 1000).toStringAsFixed(1);

    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;
    final themeBodyText1 = theme.textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 40,
        bottom: 24,
      ),
      child: Row(
        children: [
          Text(
            AppStrings.distance,
            style: themeBodyText1,
          ),
          const Spacer(),
          Text(
            'до $radiusInKilometers км',
            style: themeBodyText1?.copyWith(
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
