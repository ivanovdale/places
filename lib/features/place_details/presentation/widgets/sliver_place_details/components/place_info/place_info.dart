import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/components/place_info/components/place_description.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/components/place_info/components/place_details_info.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/components/place_info/components/place_name.dart';

/// Виджет для отображения информации о места.
///
/// Отображает название, тип, режим работы, описание места.
///
/// Обязательный параметр конструктора: [place] - модель места.
class PlaceInfo extends StatelessWidget {
  final Place place;

  const PlaceInfo(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeBodyText2 = theme.textTheme.bodyMedium;
    final onPrimaryColor = colorScheme.onPrimary;
    final secondaryColor = colorScheme.secondary;
    final primaryColor = theme.primaryColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlaceName(
          place.name,
          textStyle: theme.textTheme.headlineSmall!,
        ),
        PlaceDetailsInfo(
          place.type.toString(),
          workTime: place.workTimeFrom ?? '',
          placeTypeTextStyle: themeBodyText2!.copyWith(
            color: onPrimaryColor,
          ),
          workTimeTextStyle: themeBodyText2.copyWith(
            color: secondaryColor,
          ),
        ),
        PlaceDescription(
          place.details,
          textStyle: themeBodyText2.copyWith(
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
