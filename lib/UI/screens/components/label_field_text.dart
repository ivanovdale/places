import 'package:flutter/material.dart';

/// Произвольный заголовок для поля ввода.
///
/// Нужно задать [labelText] - имя заголовка и при необходимости [padding] - отступ для заголовка.
class LabelFieldText extends StatelessWidget {
  final String labelText;
  final EdgeInsets? padding;

  const LabelFieldText(
    this.labelText, {
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        labelText,
        style: theme.textTheme.caption?.copyWith(
          color: theme.colorScheme.secondary.withOpacity(0.56),
        ),
      ),
    );
  }
}