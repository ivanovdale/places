import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_text_button.dart';

/// Текстовая кнопка элемента истории поиска.
///
/// При нажатии заполняется поле поиска места.
class HistorySearchItemTextButton extends StatelessWidget {
  final Place place;
  final ValueSetter<Place>? onHistorySearchItemPressed;

  const HistorySearchItemTextButton({
    Key? key,
    required this.place,
    this.onHistorySearchItemPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomTextButton(
      place.name,
      textStyle: theme.textTheme.bodyLarge?.copyWith(
        color: secondaryColor,
      ),
      alignment: Alignment.centerLeft,

      // Заполняет поле поиска заданным элементом.
      onPressed: () => onHistorySearchItemPressed?.call(place),
    );
  }
}
