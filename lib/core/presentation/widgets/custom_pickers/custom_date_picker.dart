import 'package:flutter/material.dart';

/// Пикер даты с кастомизированными цветами.
class CustomDatePicker extends StatelessWidget {
  final Widget child;
  final Color? colorSchemePrimary;
  final Color? colorSchemeOnPrimary;
  final Color? colorSchemeOnSurface;
  final Color? dialogBackgroundColor;
  final ThemeData theme;

  const CustomDatePicker({
    super.key,
    required this.child,
    required this.theme,
    this.colorSchemePrimary,
    this.colorSchemeOnPrimary,
    this.colorSchemeOnSurface,
    this.dialogBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: colorSchemePrimary,
          onPrimary: colorSchemeOnPrimary,
          onSurface: colorSchemeOnSurface,
        ),
        dialogBackgroundColor: dialogBackgroundColor,
      ),
      child: child,
    );
  }
}
