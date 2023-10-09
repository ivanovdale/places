import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_colors.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_app_bar.dart';
import 'package:places/core/utils/string_extension.dart';
import 'package:places/features/add_place/domain/interactor/photo_interactor.dart';
import 'package:places/features/add_place/presentation/bloc/add_place_bloc.dart';
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

/// Экран для добавления нового места.
///
/// Позволяет выбрать категорию места, ввести его название, описание и географические координаты.
/// Также координаты можно установить, указав точку на карте.
class AddPlaceScreen extends StatelessWidget {
  const AddPlaceScreen({super.key});

  void _onFormTap(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _onCancelButtonPressed(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onFormTap(context),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.newPlace.capitalize(),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          centerTitle: true,
          toolbarHeight: 56,
          leading: CancelButton(
            onCancelButtonPressed: () => _onCancelButtonPressed(context),
          ),
          leadingWidth: 73,
        ),
        body: const AddPlaceBody(),
      ),
    );
  }
}

/// Отображает свойства добавленяемого места - категория, название, описание, координаты.
/// Позволяет ввести географические координаты места, указав точку на карте.
/// Имеет кнопку "Создать" для добавления нового места.
class AddPlaceBody extends StatefulWidget {
  const AddPlaceBody({
    super.key,
  });

  @override
  State<AddPlaceBody> createState() => _AddPlaceBodyState();
}

class _AddPlaceBodyState extends State<AddPlaceBody> {
  late final AddPlaceBloc _bloc = AddPlaceBloc(
    placeInteractor: context.read<PlaceInteractor>(),
    photoInteractor: context.read<PhotoInteractor>(),
  );

  /// Для валидации координат места.
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _latitudeFocusNode = FocusNode();
  final FocusNode _longitudeFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void _listener(BuildContext context, AddPlaceState state) => switch (state) {
        AddPlaceFormValidation() => _validateAndCreatePlace(),
        AddPlacePlaceCreation() => Navigator.of(context).pop(true),
        AddPlacePlaceCreationError() => _showErrorSnackBar(),
        _ => throw Exception('Unexpected event'),
      };

  void _validateAndCreatePlace() {
    if (_formKey.currentState?.validate() ?? false) {
      _bloc.add(
        AddPlacePlaceCreated(
          name: _nameController.text,
          lat: double.tryParse(_latitudeController.text) ?? 0.0,
          lon: double.tryParse(_longitudeController.text) ?? 0.0,
          description: _descriptionController.text,
        ),
      );
    }
  }

  void _showErrorSnackBar() {
    const snackBar = SnackBar(
      content: Text(AppStrings.errorPlaceCreation),
      showCloseIcon: true,
      duration: Duration(
        seconds: 30,
      ),
      backgroundColor: AppColors.flamingo,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _descriptionController.dispose();
    _nameFocusNode.dispose();
    _latitudeFocusNode.dispose();
    _longitudeFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    const defaultLabelPadding = EdgeInsets.only(
      left: 16,
      bottom: 12,
    );

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<AddPlaceBloc, AddPlaceState>(
        bloc: _bloc,
        listenWhen: (_, state) => state is! AddPlaceInitial,
        listener: _listener,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocSelector<AddPlaceBloc, AddPlaceState, List<File>>(
                        selector: (state) => state.photoList,
                        builder: (_, photoList) {
                          return PhotoCarousel(
                            photoList: photoList,
                            onAddNewPhotoPressed: (source) => _bloc.add(
                              AddPlacePhotoAdded(
                                source: source,
                              ),
                            ),
                            onDeletePhotoPressed: (index) => _bloc.add(
                              AddPlacePhotoDeleted(index: index),
                            ),
                          );
                        },
                      ),
                      const PlaceTypeLabel(),
                      BlocSelector<AddPlaceBloc, AddPlaceState, PlaceTypes?>(
                        selector: (state) => state.placeType,
                        builder: (_, placeType) {
                          return PlaceTypeSelectionField(
                            placeType: placeType,
                            onPlaceTypeSelected: (placeType) => _bloc.add(
                              AddPlaceTypeSet(placeType: placeType),
                            ),
                          );
                        },
                      ),
                      const PlaceTypePaddedDivider(),
                      const NameLabel(padding: defaultLabelPadding),
                      NameTextField(
                        nameController: _nameController,
                        nameFocusNode: _nameFocusNode,
                        latitudeFocusNode: _latitudeFocusNode,
                      ),
                      MapTextFields(
                        latitudeController: _latitudeController,
                        longitudeController: _longitudeController,
                        latitudeFocusNode: _latitudeFocusNode,
                        longitudeFocusNode: _longitudeFocusNode,
                        descriptionFocusNode: _descriptionFocusNode,
                      ),
                      const MarkOnMapButton(),
                      const DescriptionLabel(padding: defaultLabelPadding),
                      DescriptionTextField(
                        descriptionController: _descriptionController,
                        descriptionFocusNode: _descriptionFocusNode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: CreateButton(
                onButtonPressed: () => _bloc.add(
                  AddPlaceFormValidated(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
