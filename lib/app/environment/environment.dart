import 'package:places/app/environment/build_config.dart';
import 'package:places/app/environment/build_type.dart';

final class Environment {
  final BuildType buildType;
  final BuildConfig buildConfig;

  Environment._({
    required this.buildType,
    required this.buildConfig,
  });

  static Environment get instance => _environment;

  static late Environment _environment;

  static void init({
    required BuildConfig buildConfig,
    required BuildType buildType,
  }) =>
      _environment = Environment._(
        buildConfig: buildConfig,
        buildType: buildType,
      );
}
