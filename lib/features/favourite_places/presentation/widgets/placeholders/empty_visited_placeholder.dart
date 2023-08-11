import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/placeholders/info_placeholder.dart';

/// Отображает информацию о пустом списке посещенных мест.
class EmptyVisitedPlaceHolder extends InfoPlaceHolder {
  @override
  String get iconPath => AppAssets.emptyRoute;

  @override
  String get infoText => AppStrings.empty;

  @override
  String get descriptionText => AppStrings.infoFinishRoute;

  const EmptyVisitedPlaceHolder({
    super.key,
    super.iconSize = 64.0,
  });
}
