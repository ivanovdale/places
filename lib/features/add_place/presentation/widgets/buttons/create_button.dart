import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';
import 'package:places/helpers/app_strings.dart';

/// Кнопка создания места.
class CreateButton extends StatelessWidget {
  /// Тип достопримечательности по умолчанию.
  PlaceTypes get _defaultPlaceType => PlaceTypes.other;

  /// Режим работы места по умолчанию.
  String get _defaultWorkTimeFrom => '9:00';

  const CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 24.0,
          bottom: 16.0,
        ),
        child: CustomElevatedButton(
          AppStrings.create,
          textStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.secondary.withOpacity(0.56),
          ),
          backgroundColor: theme.colorScheme.secondaryContainer,
          height: 48,
          onPressed: () => createNewPlace(context),
        ),
      ),
    );
  }

  /// Создаёт новую достопримечательность и возвращает её на предыдущий экран, если валидация полей прошла успешно.
  void createNewPlace(BuildContext context) {
    final dataStorage = InheritedAddPlaceBodyState.of(context);
    final isDataValid = dataStorage.formKey.currentState!.validate();

    if (isDataValid) {
      final newPlace = Place(
        name: dataStorage.nameController.text,
        coordinatePoint: CoordinatePoint(
          lat: double.parse(dataStorage.latitudeController.text),
          lon: double.parse(dataStorage.longitudeController.text),
        ),
        type: dataStorage.selectedPlaceType ?? _defaultPlaceType,
        details: dataStorage.descriptionController.text,
        workTimeFrom: _defaultWorkTimeFrom,
        photoUrlList: dataStorage.newPhotoList,
      );
      Navigator.of(context).pop(newPlace);
    }
  }
}