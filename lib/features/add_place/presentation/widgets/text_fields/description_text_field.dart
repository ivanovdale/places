import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/custom_text_form_field.dart';
import 'package:places/helpers/app_strings.dart';

/// Поле ввода описания места.
class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dataStorage = InheritedAddPlaceBodyState.of(context);
    final controller = dataStorage.descriptionController;
    final focusNode = dataStorage.descriptionFocusNode;

    return CustomTextFormField(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 100,
      controller: controller,
      focusNode: focusNode,
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