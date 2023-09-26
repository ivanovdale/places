import 'package:places/core/helpers/app_assets.dart';
import 'package:places/features/map/presentation/widgets/buttons/map_button.dart';

class RefreshButton extends MapButton {
  @override
  String get iconPath => AppAssets.refresh;

  @override
  double get size => 24;

  @override
  final bool showLoadingIndicator;

  const RefreshButton({
    super.key,
    super.onPressed,
    this.showLoadingIndicator = false,
  });
}
