import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/widgets/labels/latitude_label.dart';
import 'package:places/features/add_place/presentation/widgets/labels/longitude_label.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/latitude_text_field.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/longitude_text_field.dart';

/// Поля ввода координат места.
class MapTextFields extends StatelessWidget {
  const MapTextFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LatitudeLabel(),
              LatitudeTextField(context: context),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LongitudeLabel(),
              LongitudeTextField(context: context),
            ],
          ),
        ),
      ],
    );
  }
}
