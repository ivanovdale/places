import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/label_field_text.dart';

/// Заголовок поля "Описание" места.
class DescriptionLabel extends StatelessWidget {
  final EdgeInsets? padding;

  const DescriptionLabel({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LabelFieldText(
      AppStrings.description,
      padding: padding,
    );
  }
}
