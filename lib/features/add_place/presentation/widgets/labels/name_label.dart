import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/label_field_text.dart';

/// Заголовок поля "Наименование" места.
class NameLabel extends StatelessWidget {
  final EdgeInsets? padding;

  const NameLabel({
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LabelFieldText(
      AppStrings.name,
      padding: padding,
    );
  }
}