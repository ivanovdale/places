import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:places/core/presentation/widgets/place_card/place_card.dart';

final class MapPlaceCard extends PlaceCard {
  final VoidCallback onBuildRoutePressed;

  @override
  int get topWidgetFlex => 6;

  @override
  int get bottomWidgetFlex => 4;

  @override
  bool get showDetails => false;

  @override
  bool get showVisitDate => false;

  @override
  final Widget? bottomActions;

  MapPlaceCard(
    super.place, {
    super.key,
    required super.toggleFavorites,
    required this.onBuildRoutePressed,
  }) : bottomActions = _BottomActions(
          onBuildRoutePressed: onBuildRoutePressed,
        );
}

class _BottomActions extends StatelessWidget {
  final VoidCallback? onBuildRoutePressed;

  const _BottomActions({
    required this.onBuildRoutePressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: CustomElevatedButton(
        padding: EdgeInsets.zero,
        backgroundColor: colorScheme.primary,
        height: 40,
        width: 40,
        buttonLabel: SvgPicture.asset(
          AppAssets.route,
          width: 40,
          height: 24,
          colorFilter: ColorFilter.mode(
            colorScheme.onSecondary,
            BlendMode.srcIn,
          ),
        ),
        onPressed: onBuildRoutePressed,
      ),
    );
  }
}
