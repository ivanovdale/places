import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_pickers/custom_date_picker.dart';
import 'package:places/UI/screens/components/custom_pickers/theme_configured_custom_time_picker.dart';
import 'package:places/domain/model/place.dart';

abstract final class CustomDateTimePickerHelper {
  /// Время посещения места по умолчанию.
  static const int _visitingHourByDefault = 12;

  /// Отображает пикеры для выбора даты и времени посещения места.
  /// Записывает выбранные дату и время.
  static Future<void> showDateTimePicker(
    BuildContext context,
    Place place,
    ValueSetter<DateTime> onTimePicked,
  ) async {
    // Вытащим сохранённую дату посещения из модели места.
    // Необходима при редактировании уже сохранённой даты посещения.
    final savedToVisitDate = place.visitDate;

    // В зависимости от платформы показать нативный пикер/пикеры.
    if (Platform.isAndroid) {
      await _showMaterialToVisitDateTimePickers(
        context,
        savedToVisitDate,
        onTimePicked,
      );
    } else {
      if (Platform.isIOS) {
        await _showCupertinoToVisitDateTimePicker(
          context,
          savedToVisitDate,
          onTimePicked,
        );
      }
    }
  }

  /// Отображает пикеры даты и времени в стиле Material.
  /// Обновляет вьюмодель места.
  static Future<void> _showMaterialToVisitDateTimePickers(
    BuildContext context,
    DateTime? savedToVisitDate,
    ValueSetter<DateTime> onTimePicked,
  ) async {
    final pickedDate = await _showMaterialToVisitDatePicker(
      context,
      savedToVisitDate,
    );
    if (pickedDate != null && context.mounted) {
      final pickedTime = await _showMaterialToVisitTimePicker(
        context,
        savedToVisitDate,
      );

      final pickedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime?.hour ?? _visitingHourByDefault, // По умолчанию.
        pickedTime?.minute ?? 0,
      );

      if (context.mounted) {
        onTimePicked(pickedDateTime);
      }
    }
  }

  /// Отображает пикер для выбора даты в стиле Material.
  static Future<DateTime?> _showMaterialToVisitDatePicker(
    BuildContext context,
    DateTime? savedToVisitDate,
  ) async {
    final currentDateTime = DateTime.now();
    final initialDate =
        _getPickerInitialDate(currentDateTime, savedToVisitDate);

    final pickedDate = showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 100)),
      initialDate: initialDate,
      builder: (context, child) {
        final theme = Theme.of(context);
        final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;

        return CustomDatePicker(
          child: child!,
          theme: Theme.of(context),
          colorSchemePrimary: theme.primaryColor,
          colorSchemeOnPrimary: scaffoldBackgroundColor,
          colorSchemeOnSurface: theme.primaryColorDark,
          dialogBackgroundColor: scaffoldBackgroundColor,
        );
      },
    );

    return pickedDate;
  }

  /// Отображает пикер для выбора времени в стиле Material.
  static Future<TimeOfDay?> _showMaterialToVisitTimePicker(
    BuildContext context,
    DateTime? savedToVisitDate,
  ) async {
    // Если не задано сохранённое время посещения, то установить текущее время.
    final initialTime = savedToVisitDate != null
        ? TimeOfDay(
            hour: savedToVisitDate.hour,
            minute: savedToVisitDate.minute,
          )
        : TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return ThemeConfiguredCustomTimePicker(
          child: child!,
        );
      },
    );

    return pickedTime;
  }

  /// Отображает пикер даты и времени в стиле Cupertino.
  static Future<void> _showCupertinoToVisitDateTimePicker(
    BuildContext context,
    DateTime? savedToVisitDate,
    ValueSetter<DateTime> onTimePicked,
  ) {
    return showModalBottomSheet<void>(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      context: context,
      builder: (_) {
        final currentDateTime = DateTime.now();
        final initialDate =
            _getPickerInitialDate(currentDateTime, savedToVisitDate);

        return CupertinoDatePicker(
          minimumDate: currentDateTime,
          maximumDate: currentDateTime.add(const Duration(days: 100)),
          initialDateTime: initialDate,
          onDateTimeChanged: (pickedDateTime) => onTimePicked(pickedDateTime),
        );
      },
    );
  }

  /// Возвращает начальную дату для пикера.
  ///
  /// Если дата посещения не задана и она находится в прошлом, то выберем сегодняшнюю.
  static DateTime _getPickerInitialDate(
    DateTime currentDateTime,
    DateTime? savedToVisitDate,
  ) {
    var initialDate = currentDateTime;
    if (savedToVisitDate != null && savedToVisitDate.isAfter(DateTime.now())) {
      initialDate = savedToVisitDate;
    }

    return initialDate;
  }
}
