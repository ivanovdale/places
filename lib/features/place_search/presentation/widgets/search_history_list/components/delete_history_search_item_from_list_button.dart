import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_icon_button.dart';

/// Кнопка удаления элемента истории поиска из списка.
class DeleteHistorySearchItemFromListButton extends StatelessWidget {
  final Place place;
  final ValueSetter<Place>? onDeleteHistorySearchItemPressed;

  const DeleteHistorySearchItemFromListButton({
    super.key,
    required this.place,
    this.onDeleteHistorySearchItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomIconButton(
      onPressed: () => onDeleteHistorySearchItemPressed?.call(place),
      icon: Icons.close,
      color: secondaryColor.withOpacity(0.56),
    );
  }
}
