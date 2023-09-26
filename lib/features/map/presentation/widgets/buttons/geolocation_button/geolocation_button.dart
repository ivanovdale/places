import 'package:places/core/helpers/app_assets.dart';
import 'package:places/features/map/presentation/widgets/buttons/map_button.dart';

class GeolocationButton extends MapButton {
  @override
  String get iconPath => AppAssets.geolocation;

  @override
  double get size => 32;

  const GeolocationButton({
    super.key,
    super.onPressed,
  });
}
