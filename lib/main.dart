import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:places/app/app.dart';

void main() {
  // Локализация форматирования даты в приложении.
  initializeDateFormatting('ru', '');

  runApp(
    const App(),
  );
}
