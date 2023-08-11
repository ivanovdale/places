import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_text_button.dart';

/// Кнопка "Добавить в избранное" указанное место.
class ToFavouritesButton extends StatelessWidget {
  const ToFavouritesButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = theme.primaryColor;

    return CustomTextButton(
      AppStrings.toFavourites,
      textStyle: theme.textTheme.bodyMedium?.copyWith(
        color: buttonColor,
      ),
      buttonLabel: SvgPicture.asset(
        AppAssets.heart,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          buttonColor,
          BlendMode.srcIn,
        ),
      ),
      // TODO(daniiliv): Здесь будет вызов реальной функции.
      onPressed: () {
        if (kDebugMode) {
          print('"${AppStrings.toFavourites}" button pressed.');
        }
      },
    );
  }
}
