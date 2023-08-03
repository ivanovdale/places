import 'package:flutter/material.dart';

/// Слайдер для фильтрации по расстоянию до места.
class DistanceFilterSlider extends StatelessWidget {
  const DistanceFilterSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(ivanovdale):  bloc
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final radiusInMeters = dataStorage.radius;
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
        max: maxRangeValue / 1000,
        onChanged: (currentValue) {
          final radiusInMeters =
              double.parse(currentValue.toStringAsFixed(1)) * 1000;
          // + 0.1 к радиусу - костыль для работы бэкенда.
          dataStorage.applyDistanceFilter(radiusInMeters + 0.1);
        },
        value: radiusInKilometers,
      ),
    );
  }
}
