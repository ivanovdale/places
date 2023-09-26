import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_elevated_button.dart';

abstract class MapButton extends StatelessWidget {
  abstract final String iconPath;
  abstract final double size;
  final VoidCallback? onPressed;

  bool get showLoadingIndicator => false;

  const MapButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      width: 48,
      height: 48,
      buttonLabel: !showLoadingIndicator
          ? SvgPicture.asset(
              iconPath,
              width: size,
              height: size,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColorDark,
                BlendMode.srcIn,
              ),
            )
          : const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(),
            ),
    );
  }
}
