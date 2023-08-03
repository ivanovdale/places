import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/label_field_text.dart';
import 'package:places/helpers/app_strings.dart';

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