import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/label_field_text.dart';
import 'package:places/core/helpers/app_strings.dart';

/// Заголовок поля "Описание" места.
class DescriptionLabel extends StatelessWidget {
  final EdgeInsets? padding;

  const DescriptionLabel({
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LabelFieldText(
      AppStrings.description,
      padding: padding,
    );
  }
}