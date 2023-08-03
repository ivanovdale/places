import 'package:flutter/material.dart';

/// Кнопка "Вернуться назад" в список интересных мест.
class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 24.0,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
