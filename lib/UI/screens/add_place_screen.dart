import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_divider.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/UI/screens/components/label_field_text.dart';
import 'package:places/UI/screens/components/rounded_cached_network_image.dart';
import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_router.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart' as mocked;
import 'package:places/utils/replace_comma_formatter.dart';
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
          titleTextStyle: Theme.of(context).textTheme.subtitle1,
          centerTitle: true,
          toolbarHeight: 56,
          leading: const _CancelButton(),
          leadingWidth: 73,
        ),
        body: const _AddPlaceBody(),
      ),
    );
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedAddPlaceBodyState extends InheritedWidget {
  final _AddPlaceBodyState data;

  const _InheritedAddPlaceBodyState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedAddPlaceBodyState old) {
    return true;
  }

  static _AddPlaceBodyState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            _InheritedAddPlaceBodyState>() as _InheritedAddPlaceBodyState)
        .data;
  }
}

/// Отображает свойства добавленяемого места: категория, название, описание, координаты.
/// Позволяет ввести географические координаты места, указав точку на карте.
/// Имеет кнопку "Создать" для добавления нового места.
class _AddPlaceBody extends StatefulWidget {
  const _AddPlaceBody({Key? key}) : super(key: key);

  @override
  State<_AddPlaceBody> createState() => _AddPlaceBodyState();
}

/// Состояние виджета для добавления нового места.
///
/// Содержит в себе всю верстку, контроллеры и фокусноды для полей ввода.
/// Также содержит ключ формы для валидации полей.
/// Хранит выбранный тип места.
class _AddPlaceBodyState extends State<_AddPlaceBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _latitudeFocusNode = FocusNode();
  final FocusNode _longitudeFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  /// Для валидации координат места.
  final _formKey = GlobalKey<FormState>();
  PlaceTypes? selectedPlaceType;

  /// Список добавляемых фото.
  late List<String> _newPhotoList = [];

  @override
  Widget build(BuildContext context) {
    const defaultLabelPadding = EdgeInsets.only(
      left: 16.0,
      bottom: 12.0,
    );

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: _InheritedAddPlaceBodyState(
          data: this,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _PhotoCarousel(),
              _PlaceTypeLabel(),
              _PlaceTypeSelectionField(),
              _PlaceTypePaddedDivider(),
              _NameLabel(padding: defaultLabelPadding),
              _NameTextField(),
              _MapTextFields(),
              _MarkOnMapButton(),
              _DescriptionLabel(padding: defaultLabelPadding),
              _DescriptionTextField(),
              _CreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // TODO(daniiliv): инициализация списка добавляемых фото моковыми данными.
    _newPhotoList = mocked.photoCarouselOnAddPlaceScreen;

    // Для обновления SuffixIcon в TextField.
    _nameFocusNode.addListener(() {
      setState(() {});
    });
    _latitudeFocusNode.addListener(() {
      setState(() {});
    });
    _longitudeFocusNode.addListener(() {
      setState(() {});
    });
    _descriptionFocusNode.addListener(() {
      setState(() {});
    });
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
      _newPhotoList.add(photoUrl);
    });
  }

  /// Удаляет фото из списка добавляемых фото.
  void deletePhotoFromList(int index) {
    setState(() {
      _newPhotoList.removeAt(index);
    });
  }
}

/// Заголовок поля "Категория".
class _PlaceTypeLabel extends StatelessWidget {
  const _PlaceTypeLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LabelFieldText(
      AppStrings.placeType,
      padding: EdgeInsets.only(
        left: 16.0,
        top: 24.0,
      ),
    );
  }
}

/// Заголовок поля "Наименование" места.
class _NameLabel extends StatelessWidget {
  final EdgeInsets? padding;

  const _NameLabel({
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LabelFieldText(
      AppStrings.name,
      padding: padding,
    );
  }
}

/// Заголовок поля "Описание" места.
class _DescriptionLabel extends StatelessWidget {
  final EdgeInsets? padding;

  const _DescriptionLabel({
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LabelFieldText(
      AppStrings.description,
      padding: padding,
    );
  }
}

/// Заголовок поля "Широта" координат места.
class _LatitudeLabel extends StatelessWidget {
  const _LatitudeLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(left: 16.0, top: 24, bottom: 12);

    return const LabelFieldText(
      AppStrings.latitude,
      padding: padding,
    );
  }
}

/// Заголовок поля "Долгота" координат места.
class _LongitudeLabel extends StatelessWidget {
  const _LongitudeLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(left: 8.0, top: 24, bottom: 12);

    return const LabelFieldText(
      AppStrings.longitude,
      padding: padding,
    );
  }
}

/// Поле ввода наименования места.
class _NameTextField extends StatelessWidget {
  const _NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedAddPlaceBodyState.of(context);
    final nameController = dataStorage._nameController;
    final nameFocusNode = dataStorage._nameFocusNode;
    final latitudeFocusNode = dataStorage._latitudeFocusNode;

    return _CustomTextFormField(
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

/// Поля ввода координат места.
class _MapTextFields extends StatelessWidget {
  const _MapTextFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _LatitudeLabel(),
              _LatitudeTextField(context: context),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _LongitudeLabel(),
              _LongitudeTextField(context: context),
            ],
          ),
        ),
      ],
    );
  }
}

/// Абстрактный класс для ввода координат места.
///
/// Валидирует поля ввода, позволяя вводить только десятичные числа.
/// Перемещает фокус на следующее поле при окончании редактирования.
/// Необходимо переопределить в потомках:
/// * [controller] - контроллер данного поля ввода;
/// * [focusNode] - фокусноду данного поля ввода;
/// * [nextFocusNode] - фокусноду, на которую необходимо переключиться после окончания ввода текста;
/// * [maxLength] - максимальную длину поля;
/// * [padding] - отступ для поля.
abstract class _BaseCoordinateTextField extends StatelessWidget {
  final BuildContext context;
  abstract final _AddPlaceBodyState dataStorage;
  abstract final TextEditingController controller;
  abstract final FocusNode focusNode;
  abstract final FocusNode? nextFocusNode;
  abstract final int maxLength;
  abstract final EdgeInsets? padding;

  const _BaseCoordinateTextField({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CustomTextFormField(
      controller: controller,
      focusNode: focusNode,
      nextFocusNode: nextFocusNode,
      height: 40,
      maxLength: maxLength,
      padding: padding,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        ReplaceCommaFormatter(),
      ],
      validator: coordinatePointValidator,
    );
  }

  /// Валидирует поля ввода, позволяя вводить только десятичные числа.
  String? coordinatePointValidator(String? value) {
    final digitsAndDots = RegExp(r'^(?=\D*(?:\d\D*){1,10}$)\d+(?:\.\d{1,7})?$');

    if (value == null || value.isEmpty || !digitsAndDots.hasMatch(value)) {
      return AppStrings.coordinatesValidationMessage;
    }

    return null;
  }
}

/// Поле ввода широты координат места.
///
/// Задаёт следующим полем для ввода - поле ввода долготы координат места.
/// Максимальная длина поля - 9 символов.
class _LatitudeTextField extends _BaseCoordinateTextField {
  @override
  _AddPlaceBodyState get dataStorage => _InheritedAddPlaceBodyState.of(context);

  @override
  TextEditingController get controller => dataStorage._latitudeController;

  @override
  FocusNode get focusNode => dataStorage._latitudeFocusNode;

  @override
  FocusNode? get nextFocusNode => dataStorage._longitudeFocusNode;

  @override
  int get maxLength => 9;

  @override
  EdgeInsets? get padding => const EdgeInsets.only(
        left: 16.0,
        right: 8.0,
      );

  const _LatitudeTextField({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          context: context,
        );
}

/// Поле ввода долготы координат места.
///
/// Задаёт следующим полем для ввода - поле ввода описания места.
/// Максимальная длина поля - 10 символов.
class _LongitudeTextField extends _BaseCoordinateTextField {
  @override
  _AddPlaceBodyState get dataStorage => _InheritedAddPlaceBodyState.of(context);

  @override
  TextEditingController get controller => dataStorage._longitudeController;

  @override
  FocusNode get focusNode => dataStorage._longitudeFocusNode;

  @override
  FocusNode? get nextFocusNode => dataStorage._descriptionFocusNode;

  @override
  int get maxLength => 10;

  @override
  EdgeInsets? get padding => const EdgeInsets.only(
        left: 8.0,
        right: 16.0,
      );

  const _LongitudeTextField({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          context: context,
        );
}

/// Поле ввода описания места.
class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dataStorage = _InheritedAddPlaceBodyState.of(context);
    final controller = dataStorage._descriptionController;
    final focusNode = dataStorage._descriptionFocusNode;

    return _CustomTextFormField(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 100,
      controller: controller,
      focusNode: focusNode,
      maxLength: 120,
      maxLines: 3,
      hintText: AppStrings.enterText,
      hintStyle: theme.textTheme.bodyText1?.copyWith(
        color: theme.colorScheme.secondary.withOpacity(0.56),
      ),
      unfocusWhenEditingComplete: true,
    );
  }
}

/// Произвольное поле ввода с настройками.
class _CustomTextFormField extends StatelessWidget {
  final EdgeInsets? padding;
  final double? height;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final int maxLength;
  final bool autofocus;
  final bool unfocusWhenEditingComplete;
  final String? hintText;
  final TextStyle? hintStyle;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const _CustomTextFormField({
    Key? key,
    this.padding,
    this.height,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required this.maxLength,
    this.autofocus = false,
    this.unfocusWhenEditingComplete = false,
    this.hintText,
    this.maxLines = 1,
    this.hintStyle,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSchemePrimaryColor = theme.colorScheme.primary.withOpacity(0.4);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: height ?? 0,
        child: TextFormField(
          validator: validator,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          autofocus: autofocus,
          textInputAction: (maxLines ?? 0) > 1 ? TextInputAction.done : null,
          maxLines: maxLines,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorSchemePrimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: colorSchemePrimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: focusNode.hasFocus
                ? IconButton(
                    icon: const Icon(Icons.cancel),
                    color: theme.primaryColorDark,
                    onPressed: controller.clear,
                  )
                : null,
          ),
          textAlignVertical: TextAlignVertical.top,
          style: theme.textTheme.bodyText1,
          onEditingComplete: changeFocus,
        ),
      ),
    );
  }

  /// Выполняет активацию нужного поля в зависимости от условия.
  ///
  /// Если определено поле следующего фокуса, то устанавливает его в качестве следующего поля ввода.
  /// Иначе если установлен признак отключения фокуса при завершении редактирования поля, то выполняет данное действие.
  void changeFocus() {
    if (nextFocusNode != null) {
      nextFocusNode?.requestFocus();
    } else {
      if (unfocusWhenEditingComplete) {
        focusNode.unfocus();
      }
    }
  }
}

/// Поле выбора категории места.
class _PlaceTypeSelectionField extends StatelessWidget {
  const _PlaceTypeSelectionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectionFieldTextStyle = theme.textTheme.bodyText1?.copyWith(
      color: theme.colorScheme.secondary,
    );
    final dataStorage = _InheritedAddPlaceBodyState.of(context);
    final selectedPlaceType = dataStorage.selectedPlaceType;
    final selectedPlaceTypeName =
        selectedPlaceType?.name.capitalize() ?? AppStrings.unselected;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 14.0,
      ),
      child: InkWell(
        onTap: () => selectPlaceTypeFromListOnNewScreen(context),
        child: Row(
          children: [
            Text(
              selectedPlaceTypeName,
              style: selectionFieldTextStyle,
            ),
            const Spacer(),
            const _PlaceTypeSelectionButton(),
          ],
        ),
      ),
    );
  }

  /// Позволяет выбрать тип места из списка на новом экране.
  Future<void> selectPlaceTypeFromListOnNewScreen(BuildContext context) async {
    final dataStorage = _InheritedAddPlaceBodyState.of(context);

    final selectedPlaceType = await Navigator.pushNamed<PlaceTypes>(
      context,
      AppRouter.placeTypeSelection,
    );

    if (selectedPlaceType != null) {
      dataStorage.setSelectedPlaceType(selectedPlaceType);
    }
  }
}

/// Прокручиваемый список добавляемых фотографий.
///
/// Позволяет добавить/удалить фотографии из списка.
class _PhotoCarousel extends StatelessWidget {
  const _PhotoCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedAddPlaceBodyState.of(context);

    var currentPhotoIndex = 0;
    final newPhotoList = dataStorage._newPhotoList;
    List<Widget> newPhotoCardList;
    newPhotoCardList = newPhotoList
        .map((photoUrl) {
          return _NewPhotoCard(
            photoUrl: photoUrl,
            index: currentPhotoIndex++,
          );
        })
        .cast<Widget>()
        .toList()
      ..insert(0, const _AddNewPhotoButton());

    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 24),
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: newPhotoCardList,
      ),
    );
  }
}

/// Карточка добавляемой фотографии.
class _NewPhotoCard extends StatelessWidget {
  final String photoUrl;
  final int index;

  const _NewPhotoCard({
    Key? key,
    required this.photoUrl,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Dismissible(
        key: ObjectKey(this),
        direction: DismissDirection.up,
        onDismissed: (direction) => deletePhotoFromList(context),
        child: RoundedCachedNetworkImage(
          url: photoUrl,
          canDelete: true,
          size: 72,
          onDelete: () => deletePhotoFromList(context),
        ),
      ),
    );
  }

  /// Удаляет фото из списка добавляемых фото.
  void deletePhotoFromList(BuildContext context) {
    _InheritedAddPlaceBodyState.of(context).deletePhotoFromList(index);
  }
}

/// Кнопка отмены добавления нового места.
class _CancelButton extends StatelessWidget {
  const _CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.cancel,
      textStyle: theme.textTheme.button?.copyWith(
        color: theme.colorScheme.secondary,
      ),
      padding: const EdgeInsets.only(
        left: 16.0,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

/// Кнопка добавления новой фотографии.
class _AddNewPhotoButton extends StatelessWidget {
  const _AddNewPhotoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSchemePrimaryColor = theme.colorScheme.primary;

    return GestureDetector(
      onTap: () => addPhotoToList(context),
      child: Container(
        width: 72,
        height: 72,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorSchemePrimaryColor.withOpacity(0.48),
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          size: 45,
          color: colorSchemePrimaryColor,
        ),
      ),
    );
  }

  /// Открывает диалог для добавления нового фото в список добавляемых фото.
  void addPhotoToList(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _PhotoPicker(),
    );
    // TODO(daniiliv): *Как будто сработал image picker*.
    const newPhotoUrl = mocked.newPhotoOnAddPlaceScreen;

    _InheritedAddPlaceBodyState.of(context).addPhotoToList(newPhotoUrl);
  }
}

/// Кнопка для выбора категории места.
class _PlaceTypeSelectionButton extends StatelessWidget {
  const _PlaceTypeSelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).primaryColorDark,
        size: 15.0,
      ),
    );
  }
}

/// Кнопка указания места на карте.
class _MarkOnMapButton extends StatelessWidget {
  const _MarkOnMapButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.markOnMap,
      textStyle: theme.textTheme.button?.copyWith(
        color: theme.colorScheme.primary,
      ),
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 12.0,
        bottom: 37.0,
      ),
    );
  }
}

/// Кнопка создания места.
class _CreateButton extends StatelessWidget {
  /// Тип достопримечательности по умолчанию.
  PlaceTypes get _defaultPlaceType => PlaceTypes.other;

  /// Режим работы места по умолчанию.
  String get _defaultWorkTimeFrom => '9:00';

  const _CreateButton({Key? key}) : super(key: key);

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
          textStyle: theme.textTheme.bodyText2?.copyWith(
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
    final dataStorage = _InheritedAddPlaceBodyState.of(context);
    final isDataValid = dataStorage._formKey.currentState!.validate();

    if (isDataValid) {
      final newPlace = Place(
        id: mocked.places.last.id + 1,
        name: dataStorage._nameController.text,
        coordinatePoint: CoordinatePoint(
          lat: double.parse(dataStorage._latitudeController.text),
          lon: double.parse(dataStorage._longitudeController.text),
        ),
        type: dataStorage.selectedPlaceType ?? _defaultPlaceType,
        details: dataStorage._descriptionController.text,
        workTimeFrom: _defaultWorkTimeFrom,
      );
      Navigator.of(context).pop(newPlace);
    }
  }
}

/// Позволяет выбрать фото из камеры, галереи или файлов.
class _PhotoPicker extends StatelessWidget {
  /// Действия добавления фотографии.
  List<Map<String, String>> get actions => [
        {
          'icon': AppAssets.camera,
          'text': AppStrings.camera,
        },
        {
          'icon': AppAssets.photo,
          'text': AppStrings.photo,
        },
        {
          'icon': AppAssets.file,
          'text': AppStrings.file,
        },
      ];

  const _PhotoPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onBackgroundColor = theme.colorScheme.onBackground;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _AddPhotoActions(actions: actions),
            const SizedBox(
              height: 8,
            ),
            CustomElevatedButton(
              AppStrings.cancel,
              backgroundColor: onBackgroundColor,
              height: 48,
              textStyle: theme.textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

/// Возможные действия для добавления фото.
class _AddPhotoActions extends StatelessWidget {
  final List<Map<String, String>> actions;

  const _AddPhotoActions({
    Key? key,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onBackgroundColor = theme.colorScheme.onBackground;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: onBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions
            .map((action) => _ActionItem(
                  text: action['text']!,
                  iconAsset: action['icon']!,
                  isLastItem: action['text'] == actions.last['text'],
                ))
            .toList(),
      ),
    );
  }
}

/// Действие добавления новой фотографии.
class _ActionItem extends StatelessWidget {
  final String text;
  final String iconAsset;
  final bool isLastItem;

  const _ActionItem({
    Key? key,
    required this.text,
    required this.iconAsset,
    required this.isLastItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            if (kDebugMode) {
              print('$text button pressed.');
            }
          },
          child: Row(
            children: [
              SvgPicture.asset(
                iconAsset,
                height: 24,
                color: secondaryColor,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                text,
                style: theme.textTheme.bodyText1!.copyWith(
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
        // Для последнего элемента не добавляем разделитель.
        if (!isLastItem) const _AddPhotoActionPaddedDivider(),
      ],
    );
  }
}

/// Разделитель для типа достопримечательности с заданной толщиной и отступами.
class _PlaceTypePaddedDivider extends StatelessWidget {
  const _PlaceTypePaddedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDivider(
      thickness: 0.8,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 24,
      ),
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.56),
    );
  }
}

/// Разделитель для действия добавления фото с заданной толщиной и отступами.
class _AddPhotoActionPaddedDivider extends StatelessWidget {
  const _AddPhotoActionPaddedDivider({Key? key}) : super(key: key);

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
