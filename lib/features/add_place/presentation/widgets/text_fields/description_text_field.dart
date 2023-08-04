import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/custom_text_form_field.dart';

/// Поле ввода описания места.
class DescriptionTextField extends StatelessWidget {
  final TextEditingController descriptionController;
  final FocusNode descriptionFocusNode;

  const DescriptionTextField({
    Key? key,
    required this.descriptionController,
    required this.descriptionFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextFormField(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 100,
      controller: descriptionController,
      focusNode: descriptionFocusNode,
      maxLength: 120,
      maxLines: 3,
      hintText: AppStrings.enterText,
      hintStyle: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.secondary.withOpacity(0.56),
      ),
      unfocusWhenEditingComplete: true,
    );
  }
}
