import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_icon_button.dart';

/// Кнопка возврата на экран добавления места.
class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      padding: const EdgeInsets.only(left: 16.0),
      icon: Icons.arrow_back_ios_new_rounded,
      size: 16.0,
      color: Theme.of(context).primaryColorDark,
    );
  }
}
