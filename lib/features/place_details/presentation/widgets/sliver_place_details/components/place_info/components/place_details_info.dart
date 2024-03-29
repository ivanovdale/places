import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';

/// Информация о месте.
class PlaceDetailsInfo extends StatelessWidget {
  final String text;
  final TextStyle placeTypeTextStyle;
  final TextStyle workTimeTextStyle;
  final String workTime;

  const PlaceDetailsInfo(
    this.text, {
    super.key,
    required this.placeTypeTextStyle,
    required this.workTime,
    required this.workTimeTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 2,
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: placeTypeTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Text(
              '${AppStrings.closedTo} $workTime',
              style: workTimeTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
