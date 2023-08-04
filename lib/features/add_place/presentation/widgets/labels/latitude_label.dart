import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/label_field_text.dart';

/// Заголовок поля "Широта" координат места.
class LatitudeLabel extends StatelessWidget {
  const LatitudeLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(left: 16.0, top: 24, bottom: 12);

    return const LabelFieldText(
      AppStrings.latitude,
      padding: padding,
    );
  }
}