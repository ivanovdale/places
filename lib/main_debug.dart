import 'package:flutter/material.dart';
import 'package:places/app/app.dart';
import 'package:places/app/bootstrap/bootstrap.dart';
import 'package:places/app/environment/build_config.dart';
import 'package:places/app/environment/build_type.dart';
import 'package:places/core/helpers/app_strings.dart';

void main() async {
  await bootstrap(
    buildConfig: _setUpConfig(),
    buildType: BuildType.debug,
  );

  runApp(const App());
}

BuildConfig _setUpConfig() {
  return BuildConfig(
    placeListAppBarTitle: AppStrings.placeListAppBarDebugTitle,
    placeListAppBarTitleWithLineBreak: AppStrings.placeListAppBarDebugTitleWithLineBreak
  );
}
