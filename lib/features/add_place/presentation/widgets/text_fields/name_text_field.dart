import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/custom_text_form_field.dart';

/// Поле ввода наименования места.
class NameTextField extends StatelessWidget {
  final TextEditingController nameController;
  final FocusNode nameFocusNode;
  final FocusNode latitudeFocusNode;

  const NameTextField({
    Key? key,
    required this.nameController,
    required this.nameFocusNode,
    required this.latitudeFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 40,
      controller: nameController,
      focusNode: nameFocusNode,
      nextFocusNode: latitudeFocusNode,
      maxLength: 30,
      autofocus: true,
    );
  }
}
