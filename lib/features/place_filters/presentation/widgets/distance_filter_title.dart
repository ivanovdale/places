import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/features/place_filters/presentation/bloc/place_filters_bloc.dart';
import 'package:places/helpers/app_strings.dart';

/// Заголовок фильтра по расстоянию. Отображает расстояние от и до.
class DistanceFilterTitle extends StatelessWidget {
  const DistanceFilterTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = context.select<PlaceFiltersBloc, double>(
      (bloc) => bloc.state.radius,
    );

    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;
    final themeBodyText1 = theme.textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
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
            'от 0 до $radius км',
            style: themeBodyText1?.copyWith(
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
