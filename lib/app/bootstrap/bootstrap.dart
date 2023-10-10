import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:places/app/app_dependencies.dart';
import 'package:places/app/environment/build_config.dart';
import 'package:places/app/environment/build_type.dart';
import 'package:places/app/environment/environment.dart';

Future<void> bootstrap({
  required BuildConfig buildConfig,
  required BuildType buildType,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Локализация форматирования даты в приложении.
  await initializeDateFormatting('ru', '');
  await AppDependencies.initDependencies();
  Environment.init(
    buildConfig: buildConfig,
    buildType: buildType,
  );
}
