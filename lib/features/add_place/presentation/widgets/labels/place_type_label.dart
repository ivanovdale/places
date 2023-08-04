import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/label_field_text.dart';

/// Заголовок поля "Категория".
class PlaceTypeLabel extends StatelessWidget {
  const PlaceTypeLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LabelFieldText(
      AppStrings.placeType,
      padding: EdgeInsets.only(
        left: 16.0,
        top: 24.0,
      ),
    );
  }
}