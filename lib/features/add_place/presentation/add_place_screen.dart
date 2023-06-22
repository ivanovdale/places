import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/domain/model/place.dart';
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
import 'package:places/mocks.dart' as mocked;
import 'package:places/utils/string_extension.dart';

/// Экран для добавления нового места.
///
/// Позволяет выбрать категорию места, ввести его название, описание и географические координаты.
/// Также координаты можно установить, указав точку на карте.
class AddPlaceScreen extends StatelessWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.newPlace.capitalize(),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          centerTitle: true,
          toolbarHeight: 56,
          leading: const CancelButton(),
          leadingWidth: 73,
        ),
        body: const _AddPlaceBody(),
      ),
    );
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class InheritedAddPlaceBodyState extends InheritedWidget {
  static AddPlaceBodyState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            InheritedAddPlaceBodyState>() as InheritedAddPlaceBodyState)
        .data;
  }

  final AddPlaceBodyState data;

  const InheritedAddPlaceBodyState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedAddPlaceBodyState oldWidget) {
    return true;
  }
}

/// Отображает свойства добавленяемого места - категория, название, описание, координаты.
/// Позволяет ввести географические координаты места, указав точку на карте.
/// Имеет кнопку "Создать" для добавления нового места.
class _AddPlaceBody extends StatefulWidget {
  const _AddPlaceBody({Key? key}) : super(key: key);

  @override
  State<_AddPlaceBody> createState() => AddPlaceBodyState();
}

/// Состояние виджета для добавления нового места.
///
/// Содержит в себе всю верстку, контроллеры и фокусноды для полей ввода.
/// Также содержит ключ формы для валидации полей.
/// Хранит выбранный тип места.
class AddPlaceBodyState extends State<_AddPlaceBody> {
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
  PlaceTypes? selectedPlaceType;

  /// Список добавляемых фото.
  late List<String> newPhotoList = [];

  @override
  void initState() {
    super.initState();

    // TODO(daniiliv): инициализация списка добавляемых фото моковыми данными.
    newPhotoList = mocked.photoCarouselOnAddPlaceScreen;

    // Для обновления SuffixIcon в TextField.
    nameFocusNode.addListener(() {
      setState(() {});
    });
    latitudeFocusNode.addListener(() {
      setState(() {});
    });
    longitudeFocusNode.addListener(() {
      setState(() {});
    });
    descriptionFocusNode.addListener(() {
      setState(() {});
    });
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

  @override
  Widget build(BuildContext context) {
    const defaultLabelPadding = EdgeInsets.only(
      left: 16.0,
      bottom: 12.0,
    );

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: InheritedAddPlaceBodyState(
          data: this,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PhotoCarousel(),
              PlaceTypeLabel(),
              PlaceTypeSelectionField(),
              PlaceTypePaddedDivider(),
              NameLabel(padding: defaultLabelPadding),
              NameTextField(),
              MapTextFields(),
              MarkOnMapButton(),
              DescriptionLabel(padding: defaultLabelPadding),
              DescriptionTextField(),
              CreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Устанавливает выбранный тип места.
  void setSelectedPlaceType(PlaceTypes selectedPlaceType) {
    setState(() {
      this.selectedPlaceType = selectedPlaceType;
    });
  }

  /// Добавляет новое фото в список добавляемых фото.
  void addPhotoToList(String photoUrl) {
    setState(() {
      newPhotoList.add(photoUrl);
    });
  }

  /// Удаляет фото из списка добавляемых фото.
  void deletePhotoFromList(int index) {
    setState(() {
      newPhotoList.removeAt(index);
    });
  }
}
