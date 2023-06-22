import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/label_field_text.dart';
import 'package:places/helpers/app_strings.dart';

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