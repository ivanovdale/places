import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/placeholders/info_placeholder.dart';

/// Отображает информацию о пустом списке планируемых к посещению мест.
class EmptyToVisitPlaceHolder extends InfoPlaceHolder {
  @override
  String get iconPath => AppAssets.addNewCard;

  @override
  String get infoText => AppStrings.empty;

  @override
  String get descriptionText => AppStrings.infoMarkLikedPlaces;

  const EmptyToVisitPlaceHolder({
    super.key,
    super.iconSize = 64.0,
  });
}
