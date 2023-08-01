import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/label_field_text.dart';
import 'package:places/helpers/app_strings.dart';

/// Заголовок поля "Долгота" координат места.
class LongitudeLabel extends StatelessWidget {
  const LongitudeLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(left: 8.0, top: 24, bottom: 12);

    return const LabelFieldText(
      AppStrings.longitude,
      padding: padding,
    );
  }
}