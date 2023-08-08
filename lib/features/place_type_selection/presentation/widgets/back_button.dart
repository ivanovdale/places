import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_icon_button.dart';

/// Кнопка возврата на экран добавления места.
class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      padding: const EdgeInsets.only(left: 16),
      icon: Icons.arrow_back_ios_new_rounded,
      size: 16,
      color: Theme.of(context).primaryColorDark,
    );
  }
}
