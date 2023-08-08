import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/helpers/app_constants.dart';
import 'package:places/features/place_filters/presentation/bloc/place_filters_bloc.dart';

/// Слайдер для фильтрации по расстоянию до места.
class DistanceFilterSlider extends StatelessWidget {
  const DistanceFilterSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PlaceFiltersBloc>();

    final radius = context.select<PlaceFiltersBloc, double>(
      (bloc) => bloc.state.radius,
    );
    final radiusInMeters = radius;
    final radiusInKilometers = radiusInMeters / 1000;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 2,
        thumbColor: colorScheme.background,
        tickMarkShape: SliderTickMarkShape.noTickMark,
      ),
      child: Slider(
        inactiveColor: colorScheme.secondary.withOpacity(0.56),
        divisions: 99,
        min: 0.1,
        max: AppConstants.maxRangeValue / 1000,
        onChanged: (currentValue) {
          final radiusInMeters =
              double.parse(currentValue.toStringAsFixed(1)) * 1000;
          // + 0.1 к радиусу - костыль для работы бэкенда.
          final radius = radiusInMeters + 0.1;

          bloc.add(
            PlaceFiltersRadiusSelected(
              radius: radius,
            ),
          );
        },
        value: radiusInKilometers,
      ),
    );
  }
}
