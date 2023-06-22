import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/label_field_text.dart';
import 'package:places/helpers/app_strings.dart';

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