import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:places/core/presentation/widgets/place_card/components/to_favourites_icon_button.dart';

/// Кнопка "Добавить в избранное" указанное место.
class ToFromFavouritesButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isInFavourites;

  const ToFromFavouritesButton({
    super.key,
    required this.onPressed,
    required this.isInFavourites,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = theme.primaryColor;

    return CustomTextButton(
      AppStrings.toFavourites,
      textStyle: theme.textTheme.bodyMedium?.copyWith(
        color: buttonColor,
      ),
      buttonLabel: ToFavouritesIconButton(
        key: UniqueKey(),
        isFavorite: isInFavourites,
        toggleFavorites: onPressed,
        color: buttonColor,
      ),
    );
  }
}
