import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/custom_text_form_field.dart';

/// Поле ввода наименования места.
class NameTextField extends StatelessWidget {
  const NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = InheritedAddPlaceBodyState.of(context);
    final nameController = dataStorage.nameController;
    final nameFocusNode = dataStorage.nameFocusNode;
    final latitudeFocusNode = dataStorage.latitudeFocusNode;

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
