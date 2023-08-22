import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:places/app/app.dart';
import 'package:places/app/app_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Локализация форматирования даты в приложении.
  await initializeDateFormatting('ru', '');
  final dependencies = await AppDependencies.getDependencies();

  runApp(
    App(
      appDependencies: dependencies,
    ),
  );
}
