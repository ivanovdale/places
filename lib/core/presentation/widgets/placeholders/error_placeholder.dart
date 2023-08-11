import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/placeholders/info_placeholder.dart';
import 'package:places/core/utils/string_extension.dart';

/// Отображает плейсхолдер ошибки.
class ErrorPlaceHolder extends InfoPlaceHolder {
  @override
  String get iconPath => AppAssets.error;

  @override
  String get infoText => AppStrings.error.capitalize();

  @override
  String get descriptionText => AppStrings.errorDescription;

  const ErrorPlaceHolder({
    super.key,
    super.iconSize = 64.0,
  });
}
