import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/placeholders/info_placeholder.dart';

/// Отображает информацию, что места не найдены.
class PlacesNotFoundPlaceHolder extends InfoPlaceHolder {
  @override
  String get iconPath => AppAssets.search;

  @override
  String get infoText => AppStrings.nothingFound;

  @override
  String get descriptionText => AppStrings.searchAdvice;

  const PlacesNotFoundPlaceHolder({
    super.key,
    super.iconSize = 64.0,
  });
}
