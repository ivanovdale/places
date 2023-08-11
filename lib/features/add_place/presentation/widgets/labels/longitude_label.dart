import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/label_field_text.dart';

/// Заголовок поля "Долгота" координат места.
class LongitudeLabel extends StatelessWidget {
  const LongitudeLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(left: 8, top: 24, bottom: 12);

    return const LabelFieldText(
      AppStrings.longitude,
      padding: padding,
    );
  }
}
