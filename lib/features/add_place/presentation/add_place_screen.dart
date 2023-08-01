import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/add_place/presentation/add_place_wm.dart';
import 'package:places/features/add_place/presentation/widgets/buttons/cancel_button.dart';
import 'package:places/features/add_place/presentation/widgets/buttons/create_button.dart';
import 'package:places/features/add_place/presentation/widgets/buttons/mark_on_map_button.dart';
import 'package:places/features/add_place/presentation/widgets/labels/description_label.dart';
import 'package:places/features/add_place/presentation/widgets/labels/name_label.dart';
import 'package:places/features/add_place/presentation/widgets/labels/place_type_label.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/photo_carousel.dart';
import 'package:places/features/add_place/presentation/widgets/place_type_padded_divider.dart';
import 'package:places/features/add_place/presentation/widgets/place_type_selection_field.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/description_text_field.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/map_text_fields.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/name_text_field.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/utils/string_extension.dart';

/// Экран для добавления нового места.
///
/// Позволяет выбрать категорию места, ввести его название, описание и географические координаты.
/// Также координаты можно установить, указав точку на карте.
class AddPlaceScreen extends ElementaryWidget<AddPlaceWM> {
  const AddPlaceScreen({super.key}) : super(createAddPlaceWM);

  @override
  Widget build(AddPlaceWM wm) {
    return GestureDetector(
      onTap: wm.onFormTap,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.newPlace.capitalize(),
          titleTextStyle: wm.appBarTextStyle,
          centerTitle: true,
          toolbarHeight: 56,
          leading: CancelButton(
            onCancelButtonPressed: wm.onCancelButtonPressed,
          ),
          leadingWidth: 73,
        ),
        body: AddPlaceBody(
          wm: wm,
        ),
      ),
    );
  }
}

/// Отображает свойства добавленяемого места - категория, название, описание, координаты.
/// Позволяет ввести географические координаты места, указав точку на карте.
/// Имеет кнопку "Создать" для добавления нового места.
class AddPlaceBody extends StatelessWidget {
  final AddPlaceWM wm;

  const AddPlaceBody({
    super.key,
    required this.wm,
  });

  @override
  Widget build(BuildContext context) {
    const defaultLabelPadding = EdgeInsets.only(
      left: 16.0,
      bottom: 12.0,
    );

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: wm.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<List<String>>(
                    valueListenable: wm.newPhotoList,
                    builder: (_, data, __) {
                      return PhotoCarousel(
                        newPhotoList: data,
                        onAddNewPhotoPressed: wm.addPhotoToList,
                        onDeletePhotoPressed: wm.deletePhotoFromList,
                      );
                    },
                  ),
                  const PlaceTypeLabel(),
                  ValueListenableBuilder<PlaceTypes?>(
                    valueListenable: wm.placeType,
                    builder: (_, data, __) {
                      return PlaceTypeSelectionField(
                        placeType: data,
                        onPlaceTypeSelected: wm.setPlaceType,
                      );
                    },
                  ),
                  const PlaceTypePaddedDivider(),
                  const NameLabel(padding: defaultLabelPadding),
                  NameTextField(
                    nameController: wm.nameController,
                    nameFocusNode: wm.nameFocusNode,
                    latitudeFocusNode: wm.latitudeFocusNode,
                  ),
                  MapTextFields(
                    latitudeController: wm.latitudeController,
                    longitudeController: wm.longitudeController,
                    latitudeFocusNode: wm.latitudeFocusNode,
                    longitudeFocusNode: wm.longitudeFocusNode,
                    descriptionFocusNode: wm.descriptionFocusNode,
                  ),
                  const MarkOnMapButton(),
                  const DescriptionLabel(padding: defaultLabelPadding),
                  DescriptionTextField(
                    descriptionController: wm.descriptionController,
                    descriptionFocusNode: wm.descriptionFocusNode,
                  ),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: CreateButton(
            onButtonPressed: () => unawaited(wm.createNewPlace()),
          ),
        ),
      ],
    );
  }
}
