import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/custom_pickers/custom_time_picker.dart';

/// Пикер времени с заданными цветами.
class ThemeConfiguredCustomTimePicker extends StatelessWidget {
  final Widget child;

  const ThemeConfiguredCustomTimePicker({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColorDark = theme.primaryColorDark;
    final primaryColor = theme.primaryColor;
    final scaffoldColor = theme.scaffoldBackgroundColor;
    final colorSchemeSecondaryColor = theme.colorScheme.secondary;
    final colorSchemeOnBackgroundColor = theme.colorScheme.onBackground;
    final colorSchemeSecondaryContainerColor =
        theme.colorScheme.secondaryContainer;

    return CustomTimePicker(
      child: child,
      theme: theme,
      colorSchemePrimary: colorSchemeOnBackgroundColor,
      colorSchemeOnSurface: colorSchemeSecondaryContainerColor,
      colorSchemeSurface: colorSchemeSecondaryColor,
      pickerBackGroundColor: scaffoldColor,
      pickerHourMinuteColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? primaryColorDark
              : colorSchemeSecondaryContainerColor),
      pickerHourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? scaffoldColor
              : primaryColor),
      pickerDayPeriodColor: colorSchemeSecondaryColor,
      pickerDialHandColor: primaryColorDark,
      pickerDialBackgroundColor: colorSchemeSecondaryContainerColor,
      pickerDialTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? scaffoldColor
              : primaryColorDark),
      pickerEntryModeIconColor: primaryColorDark,
      textButtonForegroundColor: primaryColorDark,
    );
  }
}
