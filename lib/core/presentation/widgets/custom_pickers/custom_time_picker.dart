import 'package:flutter/material.dart';

/// Пикер времени с кастомизированными цветами.
class CustomTimePicker extends StatelessWidget {
  final Widget child;
  final ThemeData theme;
  final Color? colorSchemePrimary;
  final Color? colorSchemeOnSurface;
  final Color? colorSchemeSurface;
  final Color pickerBackGroundColor;
  final Color? pickerHourMinuteColor;
  final Color? pickerHourMinuteTextColor;
  final Color? pickerDayPeriodColor;
  final Color? pickerDialHandColor;
  final Color? pickerDialBackgroundColor;
  final Color? pickerDialTextColor;
  final Color? pickerEntryModeIconColor;
  final Color textButtonForegroundColor;

  const CustomTimePicker({
    super.key,
    required this.child,
    required this.theme,
    this.colorSchemePrimary,
    this.colorSchemeOnSurface,
    this.colorSchemeSurface,
    required this.pickerBackGroundColor,
    this.pickerHourMinuteColor,
    this.pickerHourMinuteTextColor,
    this.pickerDayPeriodColor,
    this.pickerDialHandColor,
    this.pickerDialBackgroundColor,
    this.pickerDialTextColor,
    this.pickerEntryModeIconColor,
    required this.textButtonForegroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: colorSchemePrimary, // Enabled AM/PM text.
          onSurface: colorSchemeOnSurface, // Disabled AM/PM text.
          surface: colorSchemeSurface, // Border AM/PM.
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: pickerBackGroundColor,
          hourMinuteColor: pickerHourMinuteColor,
          hourMinuteTextColor: pickerHourMinuteTextColor,
          dayPeriodColor: pickerDayPeriodColor,
          dialHandColor: pickerDialHandColor,
          dialBackgroundColor: pickerDialBackgroundColor,
          dialTextColor: pickerDialTextColor,
          entryModeIconColor: pickerEntryModeIconColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) => textButtonForegroundColor,
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
