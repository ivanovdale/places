import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_divider.dart';

/// Разделитель для действия добавления фото с заданной толщиной и отступами.
class AddPhotoActionPaddedDivider extends StatelessWidget {
  const AddPhotoActionPaddedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDivider(
      thickness: 0.8,
      padding: const EdgeInsets.only(
        top: 13,
        bottom: 13,
      ),
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
    );
  }
}