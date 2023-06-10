import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/domain/model/place.dart';

typedef OnHistorySearchItemPressed = ValueSetter<Place>;

/// Текстовая кнопка элемента истории поиска.
///
/// При нажатии заполняется поле поиска места.
class HistorySearchItemTextButton extends StatelessWidget {
  final Place place;
  final OnHistorySearchItemPressed? onHistorySearchItemPressed;

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
