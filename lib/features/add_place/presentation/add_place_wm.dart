import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/add_place/presentation/add_place_model.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';

class AddPlaceWM extends WidgetModel<AddPlaceScreen, AddPlaceModel> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode latitudeFocusNode = FocusNode();
  final FocusNode longitudeFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  /// Для валидации координат места.
  final formKey = GlobalKey<FormState>();

  ValueListenable<List<String>> get newPhotoList => model.newPhotoList;

  ValueListenable<PlaceTypes?> get placeType => model.placeType;

  TextStyle? get appBarTextStyle => Theme.of(context).textTheme.titleMedium;

  AddPlaceWM(AddPlaceModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.loadPhotos();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    descriptionController.dispose();
    nameFocusNode.dispose();
    latitudeFocusNode.dispose();
    longitudeFocusNode.dispose();
    descriptionFocusNode.dispose();
  }

  void onFormTap() {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void setPlaceType(PlaceTypes placeType) {
    model.setPlaceType(placeType);
  }

  void addPhotoToList(String photoUrl) {
    model.addPhotoToList(photoUrl);
  }

  void deletePhotoFromList(int index) {
    model.deletePhotoFromList(index);
  }

  /// Создаёт новую достопримечательность, если валидация полей прошла успешно.
  Future<void> createNewPlace() async {
    final isDataValid = formKey.currentState!.validate();

    // TODO(ivanovdale): Возможно, нужен снекбар о том, что поля не заполнены?
    if (isDataValid) {
      await model.createNewPlace(
        name: nameController.text,
        lat: double.tryParse(latitudeController.text) ?? 0.0,
        lon: double.tryParse(longitudeController.text) ?? 0.0,
        description: descriptionController.text,
      );

      if (context.mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }

  void onCancelButtonPressed() {
    Navigator.of(context).pop(false);
  }
}
